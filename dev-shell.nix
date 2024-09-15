{
  mkShell,
  neovim,
  vimPlugins,
  plugin,
}:

mkShell {
  buildInputs = [
    (neovim.override {
      configure = {
        customRC = ''
          lua <<EOF
          local evil_mappings = require("neo-tree-evil-mappings")

          require("neo-tree").setup({
            commands = evil_mappings.commands,
            window = {
              mappings = evil_mappings.mappings,
            },
          })
          EOF
        '';
        packages.myVimPackage.start = [
          vimPlugins.neo-tree-nvim
          vimPlugins.nvim-window-picker
          plugin
        ];
      };
    })
  ];
  shellHook = ''
    export NVIM_LOG_FILE=log
    export VIM=
    export VIMRUNTIME=
    export XDG_CONFIG_HOME=$(mktemp -d)
    export XDG_DATA_HOME=$(mktemp -d)
    export VIMINIT=
    exec nvim
  '';
}
