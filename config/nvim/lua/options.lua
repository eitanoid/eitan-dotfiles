-- copied from init.lua

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = false

-- tiny diagnostic display only
vim.diagnostic.config({ virtual_text = false })

-- winbar displays directory
vim.opt.winbar = "%=%m %f"

-- redundant because mode is in status line
vim.opt.showmode = false
-- cursor options
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- 1 tab is 4 spaces instead of default 8
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 -- use tabstop option
vim.opt.expandtab = false

-- text options
vim.opt.wrap = true

-- fold
vim.opt.foldmethod = "manual"
vim.opt.foldcolumn = "1"
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
	tab = "│ ",
	trail = ".",
	extends = "»",
	precedes = "«",
	nbsp = "°",
}
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 4
