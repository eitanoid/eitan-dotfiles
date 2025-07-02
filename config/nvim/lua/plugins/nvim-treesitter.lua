local M = {}

M.opts = {
    ignore_install = { "latex" },
    ensure_installed = {
        "printf",
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "go",
        "python",
        "gap",
    },

    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        disable = { "latex" },
        additional_vim_regex_highlighting = { "ruby", "markdown" },
    },
    indent = { enable = true, disable = { "ruby" } },
}

return M
