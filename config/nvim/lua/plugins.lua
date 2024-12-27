-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--require("config.lazy")
-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--  You can press `?` in this menu for help. Use `:q` to close the window
--  To update plugins you can run
--    :Lazy update
--
--
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({

	{ -- another title screen -- possibly better and more documented than alpha
		"startup-nvim/startup.nvim",
		-- event = "VimEnter",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			require("startup").setup(require("plugins.startup"))
		end,
	},

	-- Git related plugins
	{ "tpope/vim-fugitive", event = "SafeState" },

	{ "tpope/vim-rhubarb", event = "SafeState" },
	--
	{ -- proper merge editor
		--- @see documentation at https://github.com/sindrets/diffview.nvim
		"sindrets/diffview.nvim",
		event = "SafeState",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	--
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	-- Detect tabstop and shiftwidth automatically
	{ "tpope/vim-sleuth", event = "BufEnter" },

	-- Editor Customisation
	{
		"Isrothy/neominimap.nvim",
		version = "v3.*.*",
		enabled = true,
		lazy = false, -- NOTE: NO NEED to Lazy load

		keys = require("plugins.neominimap").keys,
		init = require("plugins.neominimap").init,
	},

	-- lualine
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	--
	{ -- directory navigation
		"nvim-tree/nvim-tree.lua",
		priority = 900, -- we want this loaded pretty much immediately
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = require("plugins.nvim-tree"),
		keys = {},
	},

	-- tabs
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
			icons = {
				-- Configure the base icons on the bufferline.
				-- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
				buffer_index = false,
				buffer_number = true,
				button = "x",
			},
		},
	},

	{ -- colorizer
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = { -- set to setup table
			user_default_options = { names = true },
			buftypes = {
				"*",
				"!prompt",
				"!opoup",
				"!lazy",
			},
		},
	},

	{ -- nicer looking Markdown
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "html" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},

	{
		"lervag/vimtex",
		ft = { "latex", "tex", "bib" },
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = require("plugins.vimtex")(),
	},

	-- Tabular plugin (Vim plugin for aligning text with delimiters) :Tabular command
	{ "godlygeek/tabular" },
	--
	--
	-- Comment plugin `gc` motion
	{ "numToStr/Comment.nvim", opts = {} },
	--
	-- Useful plugin to show you pending keybinds.

	{
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		opts = require("plugins.which-key"),
	},

	{ -- todo later -- repeat keybinds and hint menus
		"anuvyklack/hydra.nvim",
		event = "BufEnter",
	},

	-- {
	-- 	"mrjones2014/smart-splits.nvim",
	-- },
	-- require("smart-splits").setup({
	-- 	-- Ignored buffer types (only while resizing)
	-- 	ignored_buftypes = {
	-- 		"nofile",
	-- 		"quickfix",
	-- 		"prompt",
	-- 	},
	-- 	-- Ignored filetypes (only while resizing)
	-- 	ignored_filetypes = { "NvimTree" },
	-- 	-- the default number of lines/columns to resize by at a time
	-- 	default_amount = 3,
	-- 	-- Desired behavior when your cursor is at an edge and you
	-- 	-- are moving towards that same edge:
	-- 	-- 'wrap' => Wrap to opposite side
	-- 	-- 'split' => Create a new split in the desired direction
	-- 	-- 'stop' => Do nothing
	-- 	-- function => You handle the behavior yourself
	-- 	-- NOTE: If using a function, the function will be called with
	-- 	-- a context object with the following fields:
	--
	-- 	-- NOTE: `at_edge = 'wrap'` is not supported on Kitty terminal
	-- 	-- multiplexer, as there is no way to determine layout via the CLI
	-- 	at_edge = "stop",
	-- 	-- Desired behavior when the current window is floating:
	-- 	-- 'previous' => Focus previous Vim window and perform action
	-- 	-- 'mux' => Always forward action to multiplexer
	-- 	float_win_behavior = "previous",
	-- 	-- when moving cursor between splits left or right,
	-- 	-- place the cursor on the same row of the *screen*
	-- 	-- regardless of line numbers. False by default.
	-- 	-- Can be overridden via function parameter, see Usage.
	-- 	move_cursor_same_row = false,
	-- 	-- whether the cursor should follow the buffer when swapping
	-- 	-- buffers by default; it can also be controlled by passing
	-- 	-- `{ move_cursor = true }` or `{ move_cursor = false }`
	-- 	-- when calling the Lua function.
	-- 	cursor_follows_swapped_bufs = false,
	-- 	-- resize mode options
	-- 	resize_mode = {
	-- 		-- key to exit persistent resize mode
	-- 		quit_key = "<ESC>",
	-- 		-- keys to use for moving in resize mode
	-- 		-- in order of left, down, up' right
	-- 		resize_keys = { "h", "j", "k", "l" },
	-- 		-- set to true to silence the notifications
	-- 		-- when entering/exiting persistent resize mode
	-- 		silent = false,
	-- 		-- must be functions, they will be executed when
	-- 		-- entering or exiting the resize mode
	-- 		hooks = {
	-- 			on_enter = nil,
	-- 			on_leave = nil,
	-- 		},
	-- 	},
	-- 	-- ignore these autocmd events (via :h eventignore) while processing
	-- 	-- smart-splits.nvim computations, which involve visiting different
	-- 	-- buffers and windows. These events will be ignored during processing,
	-- 	-- and un-ignored on completed. This only applies to resize events,
	-- 	-- not cursor movement events.
	-- 	ignored_events = {
	-- 		"BufEnter",
	-- 		"WinEnter",
	-- 	},
	-- 	-- enable or disable a multiplexer integration;
	-- 	-- automatically determined, unless explicitly disabled or set,
	-- 	-- by checking the $TERM_PROGRAM environment variable,
	-- 	-- and the $KITTY_LISTEN_ON environment variable for Kitty
	-- 	multiplexer_integration = nil,
	-- 	-- disable multiplexer navigation if current multiplexer pane is zoomed
	-- 	-- this functionality is only supported on tmux and Wezterm due to kitty
	-- 	-- not having a way to check if a pane is zoomed
	-- 	disable_multiplexer_nav_when_zoomed = true,
	-- 	-- Supply a Kitty remote control password if needed,
	-- 	-- or you can also set vim.g.smart_splits_kitty_password
	-- 	-- see https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.remote_control_password
	-- 	kitty_password = nil,
	-- 	-- default logging level, one of: 'trace'|'debug'|'info'|'warn'|'error'|'fatal'
	-- 	log_level = "info",
	-- 	-- recommended mappings
	-- 	-- resizing splits
	-- 	-- these keymaps will also accept a range,
	-- 	-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
	-- 	vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left),
	-- 	vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down),
	-- 	vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up),
	-- 	vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right),
	-- 	-- moving between splits,
	-- 	vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left),
	-- 	vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down),
	-- 	vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up),
	-- 	vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right),
	-- 	vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous),
	-- 	-- swapping buffers between windows,
	-- 	vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left),
	-- 	vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down),
	-- 	vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up),
	-- 	vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right),
	-- }),

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		config = require("plugins.telescope"),
	},

	{ "HiPhish/rainbow-delimiters.nvim" }, -- rainbow brackets and other delimiters

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			enable_check_bracket_line = false,
		},
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")

			npairs.setup({})

			npairs.add_rules({
				Rule("$", "$", "tex"),
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	--
	-- { "machakann/vim-sandwich" }, -- not needed because mini.nvim includes surround

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("plugins.tiny-inline-diagnostic").setup()
		end,
	},

	{
		"folke/trouble.nvim",
		opts = require("plugins.trouble").opts,
		cmd = require("plugins.trouble").cmd,
		keys = require("plugins.trouble").keys,
	},

	-- LSP Plugins
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	{ "Bilal2453/luvit-meta", lazy = true },

	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = require("plugins.lsp-config"),
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = require("plugins.conform").opts,
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- completion sources
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-calc", -- math
			"petertriho/cmp-git", -- Git
			"hrsh7th/cmp-nvim-lsp", -- lsp completions
			"hrsh7th/cmp-path", -- path competions
			"hrsh7th/cmp-omni", -- Neovim Omnifunc
			"kdheepak/cmp-latex-symbols", -- LaTeX Letters
			"Snikimonkd/cmp-go-pkgs", -- golang packages

			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
			},
		},
		config = require("plugins.nvim-cmp"),
	},

	require("plugins.color-scheme"),

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup({
				-- Add custom surroundings to be used on top of builtin ones. For more
				-- information with examples, see `:h MiniSurround.config`.
				custom_surroundings = nil,

				-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
				highlight_duration = 500,

				-- Module mappings. Use `''` (empty string) to disable one.
				mappings = {
					add = "sa", -- Add surrounding in Normal and Visual modes
					delete = "sd", -- Delete surrounding
					find = "sf", -- Find surrounding (to the right)
					find_left = "sF", -- Find surrounding (to the left)
					highlight = "sh", -- Highlight surrounding
					replace = "sr", -- Replace surrounding
					update_n_lines = "sn", -- Update `n_lines`
					suffix_last = "l", -- Suffix to search with "prev" method
					suffix_next = "n", -- Suffix to search with "next" method
				},

				-- Number of lines within which surrounding is searched
				n_lines = 20,

				-- Whether to respect selection type:
				-- - Place surroundings on separate lines in linewise mode.
				-- - Place surroundings on each line in blockwise mode.
				respect_selection_type = false,

				-- How to search for surrounding (first inside current line, then inside
				-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
				-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
				-- see `:h MiniSurround.config`.
				search_method = "cover",

				-- Whether to disable showing non-error feedback
				-- This also affects (purely informational) helper messages shown after
				-- idle time if user input is required.
				silent = false,
			})

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},

	{ -- fold plugin
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = "BufRead",
		keys = {
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
			},
			{
				"K",
				function()
					local winid = require("ufo").peekFoldedLinesUnderCursor()
					if not winid then
						vim.lsp.buf.hover()
					end
				end,
			},
		}, --TODO: automatically folds all my tex stuff
		config = function()
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
			for _, ls in ipairs(language_servers) do
				require("lspconfig")[ls].setup({
					capabilities = capabilities,
					-- you can add other fields for setting up lsp server in this table
				})
			end
			require("ufo").setup()
		end,
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = require("plugins.nvim-treesitter").opts,
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	},

	-- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
	-- init.lua. If you want these files, they are in the repository, so you can just download them and
	-- place them in the correct locations.

	-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
	--
	--  Here are some example plugins that I've included in the Kickstart repository.
	--  Uncomment any of the lines below to enable them (you will need to restart nvim).
	--
	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	-- require 'kickstart.plugins.lint',
	-- require 'kickstart.plugins.autopairs',
	-- require 'kickstart.plugins.neo-tree',
	-- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    This is the easiest way to modularize your config.
	--
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	-- { import = "plugins" },
	--
	-- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
	-- Or use telescope!
	-- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
	-- you can continue same window with `<space>sr` which resumes last telescope search
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: set ts=2 sw=2 noet
