{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixdevflake.url = "github:FHanko/NixDevFlake";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      nixdevflake,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nvim = nixdevflake.lib.mkNvim system;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            rustc
            cargo
            rust-analyzer
            rustfmt
            clippy
            git
            nvim
            starship
          ];

          shellHook = ''
            echo "Rust $(rustc --version)"
            eval "$(starship init bash)"
          '';
        };
      }
    );
}
