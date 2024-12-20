return function()
	-- Telescope is a fuzzy finder that comes with a lot of different things that
	-- it can fuzzy find! It's more than just a "file finder", it can search
	-- many different aspects of Neovim, your workspace, LSP, and more!
	--
	-- The easiest way to use Telescope, is to start by doing something like:
	--  :Telescope help_tags
	--
	-- After running this command, a window will open up and you're able to
	-- type in the prompt window. You'll see a list of `help_tags` options and
	-- a corresponding preview of the help.
	--
	-- Two important keymaps to use while in Telescope are:
	--  - Insert mode: <c-/>
	--  - Normal mode: ?
	--
	-- This opens a window that shows you all of the keymaps for the current
	-- Telescope picker. This is really useful to discover what Telescope can
	-- do as well as how to actually do it!

	-- [[ Configure Telescope ]]
	-- See `:help telescope` and `:help telescope.setup()`
	require("telescope").setup({
		-- You can put your default mappings / updates / etc. in here
		--  All the info you're looking for is in `:help telescope.setup()`
		--
		-- defaults = {
		--   mappings = {
		--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
		--   },
		-- },
		-- pickers = {}
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown(),
			},
		},
	})

	-- Enable Telescope extensions if they are installed
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")

	-- See `:help telescope.builtin`
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
	vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })
	vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
	vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Search Select Telescope" })
	vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current Word" })
	vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
	vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
	vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Search Resume" })
	vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
	vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })

	-- Slightly advanced example of overriding default behavior and theme
	-- vim.keymap.set("n", "<leader>/", function()
	-- 	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	-- 	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
	-- 		winblend = 10,
	-- 		previewer = false,
	-- 	}))
	-- end, { desc = "/ Fuzzily search in current buffer" })

	-- It's also possible to pass additional configuration options.
	--  See `:help telescope.builtin.live_grep()` for information about particular keys
	vim.keymap.set("n", "<leader>s/", function()
		builtin.live_grep({
			grep_open_files = true,
			prompt_title = "Live Grep in Open Files",
		})
	end, { desc = "Search / in Open Files" })

	-- Shortcut for searching your Neovim configuration files
	vim.keymap.set("n", "<leader>sn", function()
		builtin.find_files({ cwd = vim.fn.stdpath("config") })
	end, { desc = "Search Neovim files" })
end
