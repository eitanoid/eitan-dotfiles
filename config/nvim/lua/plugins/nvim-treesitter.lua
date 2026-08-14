local M = {}
-- We still keep a list of what we want
local languages = {
    "printf",
    "bash",
    "c",
    "lua",
    "markdown",
    "markdown_inline",
    "vim",
    "vimdoc",
    "go",
    "python",
    "gap",
    "gitcommit",
    "diff",
    "yaml",
    "toml",
    "json",
    "dockerfile",
}

M.languages = languages

M.setup = function()
    require 'nvim-treesitter'.install(languages)
end

return M
