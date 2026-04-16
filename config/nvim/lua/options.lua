vim.opt.number = true                                           -- Make line numbers default
vim.opt.relativenumber = true
vim.diagnostic.config({ virtual_text = false })                 -- tiny diagnostic display only
vim.opt.winbar = "%=%m %f"                                      -- winbar displays directory
-- Lualine stuff
vim.o.shortmess = vim.o.shortmess .. "S"                        -- remove search counter since done in lualine
vim.opt.showmode = false                                        -- don't show mode

vim.o.showcmd = true                                            -- show commands
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20" -- cursor
vim.opt.mouse = "a"                                             -- enable mouse

local tabsize = 4                                               -- 1 tab is 4 spaces instead of default 8
vim.opt.expandtab = true
vim.opt.tabstop = tabsize
vim.opt.shiftwidth = tabsize  -- use tabstop option
vim.opt.wrap = false          -- disable text wrapping

vim.opt.foldmethod = "manual" -- fold stuff
vim.opt.foldcolumn = "1"

vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.breakindent = true        -- wrapped lines stay indented
vim.opt.undofile = true           -- persistant undo file
vim.opt.ignorecase = true         -- case insensitive search
vim.opt.smartcase = true          -- case insensitive unless containing uppercase

vim.opt.updatetime = 250          -- decrease update time
vim.opt.timeoutlen = 400          -- decrease mapped sequence wait time

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = {
    tab = "│ ",
    trail = ".",
    extends = "»",
    precedes = "«",
    nbsp = "°",
}

vim.opt.inccommand = "split" -- preview :s in real-time
vim.opt.cursorline = true    -- highlight current row
vim.opt.scrolloff = 4        -- keep 4 lines from edge of the screen
