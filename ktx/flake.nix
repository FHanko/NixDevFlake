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
        nvim = nixdevflake.lib.mkNvim system [
          "kotlin_language_server"
          "nixd"
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            jdk21
            kotlin
            gradle
            kotlin-language-server
            git
            nvim
            starship
          ];
          shellHook = ''
            echo "Kotlin $(kotlin -version 2>&1)"
            export JAVA_HOME=${pkgs.jdk21}
            eval "$(starship init bash)"
          '';
        };
      }
    );
}
