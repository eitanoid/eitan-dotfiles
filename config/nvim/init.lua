--[[
Based on https://github.com/nvim-lua/kickstart.nvim
]]

-- set <space> as leader key
-- NOTE: must happen before plugins are required otherwise wrong leader will be used.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- improves start up time

require("options")

require("plugins")

require("keymaps")

require("autocmd")

-- to move later
require("latex.init")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
