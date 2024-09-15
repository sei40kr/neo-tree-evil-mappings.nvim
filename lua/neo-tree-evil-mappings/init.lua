local M = {}

local commands = require("neo-tree-evil-mappings.commands")

M.commands = {
	select_up_node = commands.select_up_node,
	select_down_node = commands.select_down_node,
	select_previous_sibling_node = commands.select_previous_sibling_node,
	select_next_sibling_node = commands.select_next_sibling_node,
	close_or_up = commands.close_or_up,
	expand_or_down_or_open = commands.expand_or_down_or_open,
}

M.mappings = {
	l = "expand_or_down_or_open",
	h = "close_or_up",
	["<C-k>"] = "select_up_node",
	["[["] = "select_up_node",
	gk = "select_up_node",
	["<C-j>"] = "select_down_node",
	["]]"] = "select_down_node",
	gj = "select_down_node",
	K = "select_previous_sibling_node",
	J = "select_next_sibling_node",
}

return M
