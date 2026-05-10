{ nixvim, system }:
nixvim.legacyPackages.${system}.makeNixvim {
    globals.mapleader = " ";

    colorschemes.catppuccin = {
        enable = true;
        settings.flavour = "mocha";
    };

    plugins.web-devicons.enable = true;
    plugins.treesitter.enable = true;
    plugins.telescope.enable = true;
    plugins.lualine.enable = true;
    plugins.noice.enable = true;
    plugins.which-key.enable = true;
    plugins.lsp = {
        enable = true;
        servers.zls.enable = true;
    };

    opts = {
        number = true;
        expandtab = true;
        tabstop = 4;
        shiftwidth = 4;
    };

    keymaps = import ./keymaps.nix;
}
