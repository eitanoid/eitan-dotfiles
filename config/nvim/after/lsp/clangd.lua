-- https://www.andersevenrud.net/neovim.github.io/lsp/configurations/clangd/ useful for future config
---@type vim.lsp.Config
local M = {
    cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu", "--completion-style=detailed", "--function-arg-placeholders", "--fallback-style=llvm" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    capabilities = {
        textDocument = {
            semanticHighlightingCapabilities = {
                semanticHighlighting = true,
            },
        },
    },
}
return M
