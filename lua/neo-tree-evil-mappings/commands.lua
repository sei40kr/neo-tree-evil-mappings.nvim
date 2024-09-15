local M = {}

---@enum direction
local DIRECTIONS = {
	up = -1,
	down = 1,
}

---@enum open_with
M.OPEN_WITH = {
	EDIT = 0,
	SPLIT = 1,
	VSPLIT = 2,
	RIGHTBELOW_VS = 3,
	LEFTABOVE_VS = 4,
	SPLIT_WITH_WINDOW_PICKER = 5,
	VSPLIT_WITH_WINDOW_PICKER = 6,
	TABNEW = 7,
	DROP = 8,
	TAB_DROP = 9,
	WINDOW_PICKER = 10,
}

---@param state table
---@param direction direction
local function select_sibling_node(state, direction)
	local node = state.tree:get_node()
	local parent_id = node:get_parent_id()
	if parent_id == nil then
		return
	end

	local parent = state.tree:get_node(parent_id)
	local child_ids = parent:get_child_ids()
	local old_index
	for i, id in ipairs(child_ids) do
		if id == node.id then
			old_index = i
			break
		end
	end

	local new_index = old_index + direction
	if new_index < 1 or new_index > #child_ids then
		return
	end

	require("neo-tree.ui.renderer").focus_node(state, child_ids[new_index])
end

---@param state table
M.select_up_node = function(state)
	local node = state.tree:get_node()
	local parent_id = node:get_parent_id()
	if parent_id == nil then
		return
	end
	require("neo-tree.ui.renderer").focus_node(state, parent_id)
end

---@param state table
M.select_down_node = function(state)
	local renderer = require("neo-tree.ui.renderer")
	local node = state.tree:get_node()
	if node:is_expanded() then
		local child_ids = node:get_child_ids()

		for _, id in ipairs(child_ids) do
			local child = state.tree:get_node(id)
			if child:is_expanded() then
				renderer.focus_node(state, id)
				return
			end
		end

		if 0 < #child_ids then
			renderer.focus_node(state, child_ids[1])
		end

		return
	end

	local parent_id = node:get_parent_id()
	if parent_id == nil then
		return
	end

	local sibling_ids = state.tree:get_node(parent_id):get_child_ids()
	local index
	for i, id in ipairs(sibling_ids) do
		if id == node.id then
			index = i
			break
		end
	end
	for i, id in ipairs(sibling_ids) do
		if i > index then
			local sibling = state.tree:get_node(id)
			if sibling:is_expanded() then
				renderer.focus_node(state, id)
				return
			end
		end
	end
end

---@param state table
M.select_previous_sibling_node = function(state)
	select_sibling_node(state, DIRECTIONS.up)
end

---@param state table
M.select_next_sibling_node = function(state)
	select_sibling_node(state, DIRECTIONS.down)
end

---@param state table
M.close_or_up = function(state)
	local node = state.tree:get_node()

	if node:is_expanded() then
		require("neo-tree.sources.common.commands").close_node(state)
		return
	end

	local parent_id = node:get_parent_id()
	if parent_id == nil then
		return
	end

	require("neo-tree.ui.renderer").focus_node(state, parent_id)
end

---@param state table
M.expand_or_down_or_open = function(state)
	local commands = require("neo-tree.sources.common.commands")
	local utils = require("neo-tree.utils")
	local node = state.tree:get_node()

	---@type open_with | nil
	local open_with = state.config.open_with

	if node:is_expanded() then
		if node:has_children() then
			require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
		end

		return
	end

	if utils.is_expandable(node) then
		commands.toggle_node(state, utils.wrap(require("neo-tree.sources.filesystem").toggle_directory, state))
		return
	end

	if open_with == M.OPEN_WITH.SPLIT then
		commands.open_split(state, nil)
	elseif open_with == M.OPEN_WITH.VSPLIT then
		commands.open_vsplit(state, nil)
	elseif open_with == M.OPEN_WITH.RIGHTBELOW_VS then
		commands.open_rightbelow_vs(state, nil)
	elseif open_with == M.OPEN_WITH.LEFTABOVE_VS then
		commands.open_leftabove_vs(state, nil)
	elseif open_with == M.OPEN_WITH.TABNEW then
		commands.open_tabnew(state, nil)
	elseif open_with == M.OPEN_WITH.DROP then
		commands.open_drop(state, nil)
	elseif open_with == M.OPEN_WITH.TAB_DROP then
		commands.open_tab_drop(state, nil)
	elseif open_with == M.OPEN_WITH.WINDOW_PICKER then
		commands.open_with_window_picker(state, nil)
	elseif open_with == M.OPEN_WITH.SPLIT_WITH_WINDOW_PICKER then
		commands.open_split_with_window_picker(state, nil)
	elseif open_with == M.OPEN_WITH.VSPLIT_WITH_WINDOW_PICKER then
		commands.open_vsplit_with_window_picker(state, nil)
	else
		commands.open(state, nil)
	end
end

return M
