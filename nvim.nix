{ nixvim, system }:
nixvim.legacyPackages.${system}.makeNixvim {
  colorschemes.catppuccin = {
    enable = true;
    settings.flavour = "mocha";
  };

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
}
