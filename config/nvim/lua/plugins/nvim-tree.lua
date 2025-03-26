local M = {}
M.opts = {
    filters = {
        git_ignored = false,
        custom = {
            "^\\.git",
        },
    },

    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = false,
    },
    view = {
        width = function()
            return math.floor(0.25 * vim.o.columns)
        end,
        preserve_window_proportions = true,
    },
    renderer = {
        add_trailing = true,
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = true },
        icons = {
            glyphs = {
                default = "󰈚",
                folder = {
                    default = "",
                    empty = "",
                    empty_open = "",
                    open = "",
                    symlink = "",
                },
                git = {
                    unstaged = "*",
                    staged = "󰸞",
                    unmerged = "",
                    renamed = "󰫍",
                    untracked = "󰏢",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
}

M.opts.on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    vim.api.nvim_buf_set_keymap(bufnr, "n", "h", "", {
        desc = "change root to parent",
        callback = api.tree.change_root_to_parent,
    })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "l", "", {
        desc = "change root to node",
        callback = api.tree.change_root_to_node,
    })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "r", "", {
        desc = "rename",
        callback = api.fs.rename,
    })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "n", "", {
        desc = "create new file",
        callback = api.fs.create,
    })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "p", "", {
        desc = "copy absolute path",
        callback = api.fs.copy.absolute_path,
    })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "P", "", {
        desc = "copy relative path",
        callback = api.fs.copy.relative_path,
    })
end

return M
