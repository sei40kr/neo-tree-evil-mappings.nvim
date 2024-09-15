{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
  };

  outputs =
    {
      self,
      flake-parts,
      nixpkgs,
    }@inputs:
    let
      inherit (flake-parts.lib) mkFlake;
    in
    mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { config, pkgs, ... }:
        let
          plugin = pkgs.callPackage ./package.nix { };
        in
        {
          packages.default = plugin;

          devShells.default = pkgs.callPackage ./dev-shell.nix { inherit plugin; };
        };
    };
}
