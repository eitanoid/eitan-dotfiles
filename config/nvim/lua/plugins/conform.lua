local M = {}

M.opts = {

    notify_on_error = false,
    format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
            lsp_format_opt = "never"
        else
            lsp_format_opt = "fallback"
        end
        return {
            timeout_ms = 500,
            lsp_format = lsp_format_opt,
        }
    end,
    formatters_by_ft = {
        lua = { "stylua" },
        -- tex = { "latexindent" }, -- dont like latexindent
        go = { "goimports", " gofmt" },
        -- Conform can also run multiple formatters sequentially
        python = {
            isort = {
                args = { "--ling-length", "200" },
            },
            "black",
        },
        --
        bib = { "bibtex-tidy" },
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettier" },
    },
}
return M
