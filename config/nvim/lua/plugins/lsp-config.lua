return function()
    require("mason").setup()
    local servers = {
        "bashls",
        "yamlls",
        "jsonls",
        "gopls",
        "pyright",
        "nil-ls" -- nix
        -- "bibtex-tidy",
    }
    require("mason-lspconfig").setup({
        -- Ensure these are installed automatically
        ensure_installed = servers
    })
end
