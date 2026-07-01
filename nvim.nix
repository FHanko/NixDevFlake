{
  nixvim,
  system,
  pkgs,
}:
nixvim.legacyPackages.${system}.makeNixvim {
  globals.mapleader = " ";

  colorschemes.catppuccin = {
    enable = true;
    settings.flavour = "mocha";
  };

  plugins.web-devicons.enable = true;
  plugins.telescope.enable = true;
  plugins.lualine.enable = true;
  plugins.noice.enable = true;
  plugins.which-key.enable = true;

  plugins.treesitter = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
      zig
    ];
  };

  plugins.lsp = {
    enable = true;
    servers.zls.enable = true;
    servers.nixd.enable = true;
    servers.kotlin_language_server.enable = true;
    servers.rust_analyzer.enable = true;
  };

  opts = {
    number = true;
    expandtab = true;
    tabstop = 4;
    shiftwidth = 4;
  };

  extraPackages = with pkgs; [
    ripgrep
    nixfmt
    nixd
  ];
  autoCmd = import ./auto_cmd.nix;
  keymaps = import ./keymaps.nix;
}
