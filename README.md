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
})
```

## Key Mappings

| Key(s)              | Original Key(s) | Description                                                                                                                                             |
| ------------------- | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `l`                 | -               | **For a directory**: Expand the directory if collapsed, focus its first child if expanded.<br />**For a file**: Open the file                           |
| `h`                 | -               | **For an expandable node**: Collapse the node if expanded, focus its parent if collapsed.<br />**For a non-expandable node**: Focus its parent          |
| `<C-k>`, `[[`, `gk` | -               | Focus the parent                                                                                                                                        |
| `<C-j>`, `]]`, `gj` | -               | **For an expandable node**: Expand the node if collapsed, focus its first child if expanded.<br />**For a non-expandable node**: Focus the next sibling |
| `K`                 | -               | Focus the previous sibling                                                                                                                              |
| `J`                 | -               | Focus the next sibling                                                                                                                                  |
