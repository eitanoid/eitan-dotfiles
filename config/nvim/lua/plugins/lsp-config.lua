return function()
    require("mason").setup()
    local servers = {
        "bashls",
        "yamlls",
        "jsonls",
        "gopls",
        "pyright"
        -- "bibtex-tidy",
    }
    require("mason-lspconfig").setup({
        -- Ensure these are installed automatically
        ensure_installed = servers
    })
end
