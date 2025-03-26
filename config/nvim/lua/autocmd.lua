-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- fix cursor breaking when leaving nvim
vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*",
    command = "set guicursor=a:ver25",
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Automatically create directories when opening a file
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*",
    callback = function()
        local file_path = vim.fn.expand("<afile>:p:h")
        if vim.fn.isdirectory(file_path) == 0 then
            vim.fn.mkdir(file_path, "p")
        end
    end,
})

-- Automatically create directories before saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local file_path = vim.fn.expand("<afile>:p:h")
        if vim.fn.isdirectory(file_path) == 0 then
            vim.fn.mkdir(file_path, "p")
        end
    end,
})

-- Use 'q' to close special buffer types. '' catches a lot of transient plugin windows. source: https://www.reddit.com/r/neovim/comments/1i2xw2m/comment/m7ies9g/
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "help",
        "startuptime",
        "lspinfo",
        "man",
        "checkhealth",
        "lazy",
        "vim",
    },
    command = [[
          nnoremap <buffer><silent> q :close<CR>
          nnoremap <buffer><silent> <ESC> :close<CR>
          set nobuflisted
      ]],
})

-- vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, { -- keymaps for nvim tree
--     pattern = {
--         "NvimTree",
--     },
--     callback = function()
--         local api = require("nvim-tree.api")
--         vim.api.nvim_buf_set_keymap(0, "n", "h", "", {
--             desc = "change root to parent",
--             callback = api.tree.change_root_to_parent,
--         })
--         vim.api.nvim_buf_set_keymap(0, "n", "l", "", {
--             desc = "change root to node",
--             callback = api.tree.change_root_to_node,
--         })
--         vim.api.nvim_buf_set_keymap(0, "n", "r", "", {
--             desc = "rename",
--             callback = api.fs.rename,
--         })
--         vim.api.nvim_buf_set_keymap(0, "n", "n", "", {
--             desc = "create new file",
--             callback = api.fs.create,
--         })
--         vim.api.nvim_buf_set_keymap(0, "n", "p", "", {
--             desc = "copy absolute path",
--             callback = api.fs.copy.absolute_path,
--         })
--         vim.api.nvim_buf_set_keymap(0, "n", "P", "", {
--             desc = "copy relative path",
--             callback = api.fs.copy.relative_path,
--         })
--     end,
-- })
