{ vimUtils }:

vimUtils.buildVimPlugin {
  pname = "neo-tree-evil-mappings.nvim";

  version = "1.0.0";

  src = ./.;
}
