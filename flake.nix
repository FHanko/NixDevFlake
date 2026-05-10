{
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  flake-utils.url = "github:numtide/flake-utils";
  nixvim.url = "github:nix-community/nixvim";
};

outputs = { self, nixpkgs, flake-utils, nixvim }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      nvim = nixvim.legacyPackages.${system}.makeNixvim {
		plugins.web-devicons.enable = true;

        plugins.treesitter.enable = true;
        plugins.telescope.enable = true;
        plugins.lsp = {
          enable = true;
          servers.zls.enable = true;
        };
        opts = {
          number = true;
          tabstop = 4;
          shiftwidth = 4;
        };
      };
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [ zig zls nvim git ];
      };
    });
}
