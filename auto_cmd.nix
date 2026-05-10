[
{
    event = "BufWritePre";
    pattern = "*";
    command = "%s/\\s\\+$//e";
}
{
    event = "BufWritePre";
    pattern = "*.nix";
    command = "lua vim.lsp.buf.format()";
}
]
