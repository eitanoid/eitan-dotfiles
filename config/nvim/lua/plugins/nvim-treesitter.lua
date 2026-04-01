local M = {}
-- We still keep a list of what we want
local languages = { "printf", "bash", "c", "lua", "markdown", "markdown_inline", "vim", "vimdoc", "go", "python", "gap",
    "tmux", "gitcommit", "diff", "yaml", "toml", "json", "dockerfile" }

M.languages = languages

M.setup = function()
    require 'nvim-treesitter'.install(languages)

    -- auto-enable if installed
    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("tree-sitter-enable", { clear = true }),
        callback = function(args)
            local lang = vim.treesitter.language.get_lang(args.match)
            if not lang then return end

            if vim.treesitter.query.get(lang, "highlights") then vim.treesitter.start(args.buf) end

            if vim.treesitter.query.get(lang, "indents") then
                vim.opt_local.indentexpr = 'v:lua.require(“nvim-treesitter”).indentexpr()'
            end

            if vim.treesitter.query.get(lang, "folds") then
                vim.opt_local.foldmethod = "expr"
                vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            end
        end,
    })
end

return M
