{
  nixvim,
  system,
  pkgs,
  enabledServers ? [ "nixd" ],
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
    servers = pkgs.lib.genAttrs enabledServers (name: {
      enable = true;
    });
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
