-- based on https://github.com/nvim-lua/kickstart.nvim

-- set <space> as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

require("options")
require("plugins")
require("keymaps")
require("autocmd")

-- to move later
require("latex.init")
-- vim: ts=2 sts=2 sw=2 et
