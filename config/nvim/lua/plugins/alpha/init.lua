local M = {}

-- My personal alpha.nvim config. Featuring a color animated header, scrolling text elements. Reworked the code from:
-- Animated alpha header from https://github.com/naestech/nvim/blob/main/lua/nae/plugins/alpha.lua
-- Colored alpha header from https://github.com/FoxPlays24/neovem-config/blob/ccd6286c636b2e2978cf47e8dcb77fc9ef04a846/lua/config/alpha.lua

local config = vim.fn.stdpath("config")

-------------------------------------
--- Variables For Animated Header ---
-------------------------------------

local animation_file = config .. "/lua/plugins/alpha/themes/" .. "/coplands-animation.txt" -- path to the animation ascii art map
local colors_file = config .. "/lua/plugins/alpha/themes/" .. "/coplands-colortest.txt" -- path to the animation color map
local frame_delay = 300 -- Header animation delay between frames in ms

---------------------------
--- Animation Color Map ---
---------------------------

local color_key = { -- format is the same as vim highlights. not case sensitive.
	["G"] = { fg = "#0586ad" },
	["B"] = { fg = "#5fd6fa" },
	-- ["G"] = { fg = "#999999" },
	-- ["g"] = { fg = "#555555" },
}

M.config = function()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")
	local animation = require("plugins.alpha.alpha_colored_animation")

	--------------
	--- Colors ---
	--------------

	vim.api.nvim_set_hl(0, "AlphaFooterWhite", { fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "AlphaFooterGray", { fg = "#999999" })
	vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#5fd6fa" })

	local buttons = {
		-- { type = "text", val = "Quick links", opts = { hl = "buttons1", position = "center" } }, can add a button title
		dashboard.button("i", " New File", ":ene <BAR> startinsert <cr>"),
		dashboard.button("r", " Recent Files", ":Telescope oldfiles<cr>"),
		dashboard.button("<leader>ff", " File Browser", "<Cmd>NvimTreeToggle<CR>"),
		dashboard.button("e", "󰈞 Find File", ":Telescope find_files<cr>"),
		dashboard.button("c", " Colorschemes", ":Telescope colorscheme<cr>"),
		dashboard.button("q", " Exit Vim", ":q<cr>"),
	}

	-- debug command. show the table of button opts :lua print(vim.inspect(require("alpha.themes.dashboard").button("c", "title", ":command<cr>")))

	for key, _ in ipairs(buttons) do
		buttons[key].opts.hl_shortcut = "AlphaButtons" -- rhs colors
		buttons[key].opts.hl = "AlphaButtons" -- lhs colors
		buttons[key].opts.width = 35 -- width of button in columns
		buttons[key].opts.cursor = 17 -- cursor position on this button
	end
	dashboard.section.buttons.val = buttons

	dashboard.config.layout = {
		{ type = "padding", val = 2 },
		dashboard.section.header,
		{ type = "padding", val = 2 },
		{
			type = "text", -- subheader at index #4.
			val = "",
			opts = { hl = "AlphaFooterGray", position = "center" },
		},
		{ type = "padding", val = 2 },
		dashboard.section.buttons,
		{ type = "padding", val = 2 },
	}

	alpha.setup(dashboard.config) -- initialize static elements

	------------------------
	--- Dynamic Elements ---
	------------------------

	local header_config = {
		frames = animation_file, -- path to animation file
		color_frames = colors_file, -- path to colors file
		color_map = color_key, -- map of symbol to colors
		frame_delay = frame_delay, -- map of symbol to colors
	}

	-- create header animation loop
	animation.init_header_animation(alpha, dashboard, header_config)

	local subheader_config = {
		val = "                                        No matter where you go, everyone's connected.",
		width = 35, --# width of shown text
		frame_delay = 100, -- ms
		speed = 1, -- # of shifts per frame. Negative value changes direction
	}
	-- create subheader animation loop
	animation.init_section_scroller(alpha, dashboard.config.layout[4], subheader_config) -- subheader is at index 4

	-- Draw footer after startup to include startup information
	vim.api.nvim_create_autocmd("User", {
		once = true,
		pattern = "LazyVimStarted",
		callback = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100) -- ms to 2 decimals
			local plugins_loaded = "Loaded " .. stats.loaded .. "/" .. stats.count .. " Plugins in " .. ms .. "ms"

			local clock = " " .. os.date("%H:%M")
			local date = " " .. os.date("%d-%m-%y")

			local footer = {
				{ type = "text", val = clock, opts = { hl = "AlphaFooterGray", position = "center" } },

				{ type = "text", val = date, opts = { hl = "AlphaFooterGray", position = "center" } },
				{ type = "padding", val = 1 },
				{
					type = "text",
					val = "Coplands OS Enterprise",
					opts = { hl = "AlphaFooterWhite", position = "center" },
				},
				{
					type = "text",
					val = "Produced by Tachibana Lab",
					opts = { hl = "AlphaFooterWhite", position = "center" },
				},
				{ type = "padding", val = 1 },
				{ type = "text", val = plugins_loaded, opts = { hl = "AlphaFooterGray", position = "center" } },
			}

			for i = 1, #footer do
				table.insert(dashboard.config.layout, footer[i])
			end

			pcall(vim.cmd.AlphaRedraw)
		end,
	})
end

return M
