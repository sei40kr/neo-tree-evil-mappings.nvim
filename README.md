# neo-tree-evil-mappings.nvim

[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) key mappings like [emacs-neotree](https://github.com/jaypei/emacs-neotree) in [Doom Emacs](https://github.com/doomemacs/doomemacs)

## Usage

```lua
local evil_mappings = require("neo-tree-evil-mappings")

require("neo-tree").setup({
  commands = vim.tbl_extend("force", evil_mappings.commands, {
    -- You can define your own commands here
  }),
  window = {
    mappings = evil_mappings.vim.tbl_extend("force", evil_mappings.window.mappings, {
      -- You can define your own mappings here
    }),
  },
  filesystem = {
    window = {
      mappings = vim.tbl_extend("force", evil_mappings.filesystem_mappings, {
        -- You can define your own mappings
      },
    },
  },
})
```

## Key Mappings

### Common

| Key(s)                   | Original Key(s) | Description                                                                                                                                             |
| ------------------------ | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `h`                      | -               | **For an expandable node**: Collapse the node if expanded, focus its parent if collapsed.<br />**For a non-expandable node**: Focus its parent          |
| `l`                      | -               | **For a directory**: Expand the directory if collapsed, focus its first child if expanded.<br />**For a file**: Open the file                           |
| `H`, `<C-k>`, `[[`, `gk` | -               | Focus the parent                                                                                                                                        |
| `L`, `<C-j>`, `]]`, `gj` | -               | **For an expandable node**: Expand the node if collapsed, focus its first child if expanded.<br />**For a non-expandable node**: Focus the next sibling |
| `J`                      | -               | Focus the next sibling                                                                                                                                  |
| `K`                      | -               | Focus the previous sibling                                                                                                                              |
| `go`                     | `P`             | Toggle Preview Mode                                                                                                                                     |
| `s`, `-`                 | `S`             | Open the file in a new horizontal split sibling                                                                                                         |
| `v`, `\|`                | `s`             | Open the file in a vertical split sibling                                                                                                               |

### Filesystem

| Key(s) | Original Key(s) | Description                                                   |
| ------ | --------------- | ------------------------------------------------------------- |
| `gh`   | `H`             | Toggle whether hidden are shown or not                        |
| `gr`   | `R`             | Rescan the filesystem and redraw the tree                     |
| `R`    | `.`             | Change the root directory to the currently selected directory |
| `u`    | `<BS>`          | Moves the root directory up one level                         |
