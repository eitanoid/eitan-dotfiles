-- https://go.googlesource.com/tools/+/refs/heads/master/gopls/doc/settings.md
---@type vim.lsp.Config
local M = {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gosum' },
    root_markers = { 'go.mod', 'go.sum' },
    gopls = {
        usePlaceholders = false,
        completeUnimported = false,
    },
}
return M
