-- just copying from init.lua rn

-- Set <space> as the leader key
-- See `:help mapleader`
--
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
--vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
--vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setqflist()<CR>", { desc = "Display diagnostics" })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Clear highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Buffer Keymaps
vim.keymap.set("n", "<C-Tab>", ":bnext<CR>", { desc = "Next Buffer (Tab)" })
vim.keymap.set("n", "<C-S-Tab>", ":bprevious<CR>", { desc = "Previous Buffer (Tab)" })

vim.keymap.set("n", "<C-`>", function()
	vim.wo.relativenumber = not vim.wo.relativenumber
end, { noremap = true, desc = "toggle relative numbers" })

-- Nvim-Tree
vim.keymap.set("n", "<leader>ff", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle file tr[ee]" })

-- Edit keymaps for binds I might forget
vim.keymap.set("n", "<leader>e%", "%", { desc = "Move to Matching Delimiter - %" })
vim.keymap.set("n", "<leader>eyi", "yi", { desc = "Yank Text Inside Next Delimiter" })
vim.keymap.set("n", "<leader>e>", ">", { desc = "Indent Forwards" })
vim.keymap.set("n", "<leader>e<", "<", { desc = "Indent Backwards" })

vim.keymap.set("n", "<leader>/", "gcc", { desc = "Toggle Comment" })
