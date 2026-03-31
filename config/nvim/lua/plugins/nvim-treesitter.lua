local M = {}
-- We still keep a list of what we want
local languages = { "printf", "bash", "c", "lua", "markdown", "markdown_inline", "vim", "vimdoc", "go", "python", "gap",
    "tmux", "gitcommit" }

M.languages = languages

M.setup = function()
    require 'nvim-treesitter'.install(languages)

    vim.api.nvim_create_autocmd('FileType', {
        pattern = languages,
        callback = function()
            vim.treesitter.start()
            -- You can also enable indentation here
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
    })
end

return M
