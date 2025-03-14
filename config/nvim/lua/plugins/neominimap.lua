local M = {}
--@module "neominimap.config.meta"
-- M.keys = {
-- -- Global Minimap Controls
-- { "<leader>mm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
-- { "<leader>mo", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
-- { "<leader>mc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
-- { "<leader>mr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },
--
-- -- Window-Specific Minimap Controls
-- { "<leader>mwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
-- { "<leader>mwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
-- { "<leader>mwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
-- { "<leader>mwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },
--
-- -- Tab-Specific Minimap Controls
-- { "<leader>mtt", "<cmd>Neominimap tabToggle<cr>", desc = "Toggle minimap for current tab" },
-- { "<leader>mtr", "<cmd>Neominimap tabRefresh<cr>", desc = "Refresh minimap for current tab" },
-- { "<leader>mto", "<cmd>Neominimap tabOn<cr>", desc = "Enable minimap for current tab" },
-- { "<leader>mtc", "<cmd>Neominimap tabOff<cr>", desc = "Disable minimap for current tab" },
--
-- -- Buffer-Specific Minimap Controls
-- { "<leader>mbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
-- { "<leader>mbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
-- { "<leader>mbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
-- { "<leader>mbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },
--
-- ---Focus Controls
-- { "<leader>mf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
-- { "<leader>mu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
-- { "<leader>ms", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
-- }

M.init = function()
	-- The following options are recommended when layout == "float"
	vim.opt.wrap = false
	vim.opt.sidescrolloff = 36 -- Set a large value

	--- Put your configuration here
	----@type Neominimap.UserConfig
	vim.g.neominimap = {

		winblend = 100,
		auto_enable = true,

		log_level = vim.log.levels.OFF, ---@type Neominimap.Log.Levels

		-- Notification level
		notification_level = vim.log.levels.INFO, ---@type Neominimap.Log.Levels

		-- Path to the log file
		log_path = vim.fn.stdpath("data") .. "/neominimap.log", ---@type string

		-- Minimap will not be created for buffers of these types
		---@type string[]
		---
		exclude_filetypes = {
			"help",
			"bigfile", -- For Snacks.nvim
		},

		-- Minimap will not be created for buffers of these types
		---@type string[]
		exclude_buftypes = {
			"nofile",
			"nowrite",
			"quickfix",
			"terminal",
			"prompt",
		},

		-- When false is returned, the minimap will not be created for this buffer
		---@type fun(bufnr: integer): boolean
		buf_filter = function()
			return true
		end,

		-- When false is returned, the minimap will not be created for this window
		---@type fun(winid: integer): boolean
		win_filter = function()
			return true
		end,

		-- How many columns a dot should span
		x_multiplier = 8, ---@type integer

		-- How many rows a dot should span
		y_multiplier = 2, ---@type integer

		---@alias Neominimap.Config.LayoutType "split" | "float"

		--- Either `split` or `float`
		--- When layout is set to `float`,
		--- the minimap will be created in floating windows attached to all suitable windows
		--- When layout is set to `split`,
		--- the minimap will be created in one split window
		layout = "float", ---@type Neominimap.Config.LayoutType

		--- Used when `layout` is set to `split`
		split = {
			minimap_width = 10, ---@type integer

			-- Always fix the width of the split window
			fix_width = false, ---@type boolean

			---@alias Neominimap.Config.SplitDirection "left" | "right"
			direction = "right", ---@type Neominimap.Config.SplitDirection

			---Automatically close the split window when it is the last window
			close_if_last_window = true, ---@type boolean
		},

		--- Used when `layout` is set to `float`
		float = {
			minimap_width = 6, ---@type integer

			--- If set to nil, there is no maximum height restriction
			--- @type integer
			max_minimap_height = nil,

			margin = {
				right = 0, ---@type integer
				top = 0, ---@type integer
				bottom = 0, ---@type integer
			},
			z_index = 1, ---@type integer

			--- Border style of the floating window.
			--- Accepts all usual border style options (e.g., "single", "double")
			--- @type string | string[] | [string, string][]
			window_border = "single",
		},

		-- For performance issue, when text changed,
		-- minimap is refreshed after a certain delay
		-- Set the delay in milliseconds
		delay = 200, ---@type integer

		-- Sync the cursor position with the minimap
		sync_cursor = true, ---@type boolean

		click = {
			-- Enable mouse click on minimap
			enabled = true, ---@type boolean
			-- Automatically switch focus to minimap when clicked
			auto_switch_focus = false, ---@type boolean
		},

		diagnostic = {
			enabled = true, ---@type boolean
			severity = vim.diagnostic.severity.WARN, ---@type vim.diagnostic.SeverityInt
			mode = "line", ---@type Neominimap.Handler.Annotation.Mode
			priority = {
				ERROR = 100, ---@type integer
				WARN = 90, ---@type integer
				INFO = 80, ---@type integer
				HINT = 70, ---@type integer
			},
			icon = {
				ERROR = "󰅚 ", ---@type string
				WARN = "󰀪 ", ---@type string
				INFO = "󰌶 ", ---@type string
				HINT = " ", ---@type string
			},
		},

		git = {
			enabled = true, ---@type boolean
			mode = "sign", ---@type Neominimap.Handler.Annotation.Mode
			priority = 6, ---@type integer
			icon = {
				add = "+ ", ---@type string
				change = "~ ", ---@type string
				delete = "- ", ---@type string
			},
		},

		search = {
			enabled = false, ---@type boolean
			mode = "line", ---@type Neominimap.Handler.Annotation.Mode
			priority = 20, ---@type integer
			icon = "󰱽 ", ---@type string
		},

		treesitter = {
			enabled = true, ---@type boolean
			priority = 200, ---@type integer
		},

		mark = {
			enabled = true, ---@type boolean
			mode = "icon", ---@type Neominimap.Handler.Annotation.Mode
			priority = 10, ---@type integer
			key = "m", ---@type string
			show_builtins = false, ---@type boolean -- shows the builtin marks like [ ] < >
		},
	}
end

return M
