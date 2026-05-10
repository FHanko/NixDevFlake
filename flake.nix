{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      nixvim,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nvim = import ./nvim.nix { inherit nixvim system pkgs; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            zig
            zls
            git
            nvim
          ];

          shellHook = ''
            echo "Zig $(zig version)"
          '';
        };
      }
    );
}
