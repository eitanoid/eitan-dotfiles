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

-- TEMPORARY TO TURN INTO CONDITIONAL IMPORT

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

-- Cool thing I saw in a vimtex video skip to next instance of (<>) and remove it.
vim.api.nvim_create_user_command("JumpToPlaceholder", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row, col = cursor[1] - 1, cursor[2]

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	local pattern = "%(%<%>%)"
	for i = row, #lines - 1 do
		local line = lines[i + 1]
		local start_idx, end_idx = line:find(pattern, i == row and col + 1 or 1)

		if start_idx and end_idx then
			vim.api.nvim_win_set_cursor(0, { i + 1, start_idx - 1 })
			local new_line = line:sub(1, start_idx - 1) .. line:sub(end_idx + 1)
			vim.api.nvim_buf_set_lines(bufnr, i, i + 1, false, { new_line })
			vim.cmd("startinsert")
			return
		end
	end
	print("No instance of (<>) found")
end, {})

vim.keymap.set(
	"n",
	"<leader><leader>",
	"<Cmd>JumpToPlaceholder<CR>",
	{ desc = "Jump to next occurence of (<>) and enter insert mode" }
)

-- vim.api.nvim_create_user_command("TeXMat", function()
-- 	-- get user input
-- 	local rows = tonumber(vim.fn.input("Rows: "))
-- 	if not rows or rows <= 0 then
-- 		print("Invalid number of rows.")
-- 		return
-- 	end
-- 	local cols = tonumber(vim.fn.input("Cols:"))
-- 	if not cols or cols <= 0 then
-- 		print("Invalid number of rows.")
-- 		return
-- 	end
-- 	-- make matrix
-- 	local full_mat = {}
-- 	local line = "(<>)" .. string.rep(" & (<>)", cols - 1) .. "\\" .. "\\"
-- 	table.insert(full_mat, "\\begin{pmatrix}")
-- 	for var = 1, cols do
-- 		table.insert(full_mat, line)
-- 	end
-- 	table.insert(full_mat, "\\end{pmatrix}")
-- 	-- print matrix
-- 	vim.api.nvim_put(full_mat, "l", false, false)
-- end, {})
--
-- vim.api.nvim_create_user_command("TeXMatArgs", function(opts) -- prompt user for line and col and creatematrix
-- 	-- get args
-- 	print(opts.fargs)
-- 	local rows = tonumber(opts.fargs[1])
-- 	local cols = tonumber(opts.fargs[2])
-- 	local env = tostring(opts.fargs[3])
--
-- 	local err = ""
-- 	if not rows or rows <= 0 then
-- 		err = err .. "Rows invalid"
-- 	end
-- 	if not cols or cols <= 0 then
-- 		err = err .. "Cols invalid"
-- 	end
-- 	if err then
-- 		return err
-- 	end
--
-- 	-- make matrix
-- 	local full_mat = {}
-- 	local line = "(<>)" .. string.rep(" & (<>)", cols - 1) .. " \\" .. "\\"
-- 	table.insert(full_mat, "\\begin{" .. env .. "}")
-- 	for var = 1, cols do
-- 		table.insert(full_mat, line)
-- 	end
-- 	table.insert(full_mat, "\\end{" .. env .. "}")
-- 	-- print matrix
-- 	vim.api.nvim_put(full_mat, "l", false, false)
-- end, { nargs = "*" })
