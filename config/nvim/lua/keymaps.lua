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
--
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
vim.keymap.set("n", "<A-l>", "<Cmd>bnext<CR>", { desc = "Next Buffer (Tab)" })
vim.keymap.set("n", "<A-S-h>", "<Cmd>bnext<CR>", { desc = "Next Buffer (Tab)" })
vim.keymap.set("n", "<A-S-l>", "<Cmd>bprevious<CR>", { desc = "Previous Buffer (Tab)" })
vim.keymap.set("n", "<A-h>", "<Cmd>bprevious<CR>", { desc = "Previous Buffer (Tab)" })

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
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local pattern = "%(%<%>%)"
	local lines = vim.api.nvim_buf_get_lines(0, row - 1, row + 30, false) -- from this row til 30 rows down inclusive
	local p_x

	for p_y, line in pairs(lines) do
		if p_y == 1 then
			if col < 2 then -- if too close to left edge set 0, otherwise remove 2 so curosr at anypoint of placeholder still goes to the same one.
				col = 0
			else
				col = col - 2
			end

			p_x, _ = line:find(pattern, col) -- search after the cursor on current line
		else
			p_x, _ = line:find(pattern)
		end

		if p_x then -- once found pattern
			print(p_x, p_y)
			vim.api.nvim_win_set_cursor(0, { row + p_y - 1, p_x - 1 })
			-- vim.api.nvim_buf_set_lines(0, row-1, row,false,line[]) TODO: use vimapi at some point for this because feedkeys is jank

			vim.api.nvim_feedkeys("v3lc", "n", false) -- select 3 ahead, go into change mode
			break
		end
	end

	print("No instance of (<>) found within 30 lines")
end, {})

vim.keymap.set(
	"n",
	"<leader><leader>",
	"<Cmd>JumpToPlaceholder<CR>",
	{ desc = "Jump to next occurence of (<>) and enter insert mode" }
)

vim.api.nvim_create_user_command("FlipBool", function()
	local word = vim.fn.expand("<cword>")
	local case = {
		["TRUE"] = "FALSE",
		["True"] = "False",
		["true"] = "false",
		["FALSE"] = "TRUE",
		["False"] = "True",
		["false"] = "true",
	}
	local row, col = unpack(vim.api.nvim_win_get_cursor(0)) -- curent position
	local line = vim.fn.getline(row)
	local char = line:sub(col + 1, col + 1)

	if not char:match("%a") then -- cursor is on an ascii char and not a word.
		return
	end

	if case[word] then
		vim.cmd("normal ciw" .. case[word]) -- swaps
		local newc = vim.api.nvim_win_get_cursor(0)[2] -- get new col
		if col > newc then
			col = col - 1
		end
		vim.api.nvim_win_set_cursor(0, { row, col })
	end
end, { desc = "Toggle Boolian" })

vim.keymap.set("n", "<C-X>", "<CMD>FlipBool<CR>", { desc = "Toggle Bool Under Cursor" })
vim.keymap.set("n", "<C-A>", "<CMD>FlipBool<CR>", { desc = "Toggle Bool Under Cursor" })
