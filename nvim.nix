{
  nixvim,
  system,
  pkgs,
  servers ? { },
}:
nixvim.legacyPackages.${system}.makeNixvimWithModule {
  inherit pkgs;
  module = {
    plugins.lsp = {
      enable = true;
      inherit servers;
    };
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

    plugins.neo-tree = {
      enable = true;
      settings.filesystem = {
        follow_current_file.enabled = true;
        hijack_netrw_behavior = "open_current";
      };
      settings.window = {
        width = 25;
      };
    };

    plugins.treesitter = {
      enable = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        nix
        zig
        kotlin
        rust
        toml
        markdown
        bash
      ];
    };

    plugins.blink-cmp = {
      enable = true;
      settings = {
        sources.default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
        keymap.preset = "enter";
      };
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
  };
}
