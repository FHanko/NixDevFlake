{
  description = "A collection of flake templates";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixvim,
    }:
    {

      templates = {

        ktx = {
          path = ./ktx;
          description = "Kotlin dev flake";
        };

        rust = {
          path = ./rust;
          description = "Rust dev flake";
        };
      };

      defaultTemplate = self.templates.ktx;

      lib.mkNvim =
        system:
        import ./nvim.nix {
          inherit nixvim system;
          pkgs = nixpkgs.legacyPackages.${system};
        };
    };
}
