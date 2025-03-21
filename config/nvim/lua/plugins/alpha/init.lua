local M = {}

-- My personal alpha.nvim theme featuring a color and animated header. Reworked the code from:
-- Animated alpha header from https://github.com/naestech/nvim/blob/main/lua/nae/plugins/alpha.lua
-- Colored alpha header from https://github.com/FoxPlays24/neovem-config/blob/ccd6286c636b2e2978cf47e8dcb77fc9ef04a846/lua/config/alpha.lua

-------- Variables For Animated Header -------------

local config = vim.fn.stdpath("config")
local animation_file = config .. "/lua/plugins/alpha/themes/" .. "/coplands-animation.txt" -- path to the animation ascii art map
local colors_file = config .. "/lua/plugins/alpha/themes/" .. "/coplands-animation-colormap.txt" -- path to the animation color map
local frame_delay = 500 -- Header animation delay between frames in ms

-------- Color map for the animation map file --------

local color_key = {
	["-"] = { fg = "#ff0000" }, -- Empty (Red)
	["G"] = { fg = "#555555" }, -- Gray (kind of)
	["X"] = { fg = "#999999" },
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
		-- { type = "text", val = "Quick links", opts = { hl = "buttons1", position = "center" } },
		dashboard.button("i", " New Fie", ":ene <BAR> startinsert <cr>"),
		dashboard.button("r", " Recent Files", ":Telescope oldfiles<cr>"),
		dashboard.button("<leader>ff", " File Browser", "<Cmd>NvimTreeToggle<CR>"),
		dashboard.button("e", "󰈞 Find File", ":Telescope find_files<cr>"),
		dashboard.button("c", " Colorschemes", ":Telescope colorscheme<cr>"),
		dashboard.button("q", " Exit Vim", ":q<cr>"),
	}

	-- debug to show the table of button opts :lua print(vim.inspect(require("alpha.themes.dashboard").button("c", " Colorschemes", ":Telescope colorscheme<cr>")))

	for key, _ in ipairs(buttons) do
		buttons[key].opts.hl_shortcut = "AlphaButtons" -- rhs colors
		buttons[key].opts.hl = "AlphaButtons" -- lhs colors
		buttons[key].opts.width = 35 -- number of columns width
		buttons[key].opts.cursor = 17 -- number of columns width
	end
	dashboard.section.buttons.val = buttons

	dashboard.config.layout = {
		{ type = "padding", val = 2 },
		dashboard.section.header,
		{ type = "padding", val = 2 },
		{
			type = "text",
			val = "No matter where you go, everyone's connected.",
			opts = { hl = "AlphaFooterGray", position = "center" },
		},
		{ type = "padding", val = 2 },
		dashboard.section.buttons,
		{ type = "padding", val = 2 },
		dashboard.section.footer,
	}

	animation.init_header(dashboard, animation_file, color_key, colors_file) -- first frame of header

	alpha.setup(dashboard.config)

	animation.init_animation(dashboard, alpha, animation_file, colors_file, color_key, frame_delay) -- animate header

	-- Draw Footer with information after lazy startup to show plugin and load time
	vim.api.nvim_create_autocmd("User", {
		once = true,
		pattern = "LazyVimStarted",
		callback = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			local plugins_loaded = "Loaded " .. stats.loaded .. "/" .. stats.count .. " Plugins in " .. ms .. "ms"
			local row_len = string.len(plugins_loaded)

			local clock = string.rep(" ", row_len / 2 - 3) .. " " .. os.date("%H:%M") --always of length ahh:mm 6. 6/2 = 3
			local date = string.rep(" ", row_len / 2 - 4) .. " " .. os.date("%d-%m-%y") -- mdd-mm-yy 9. 9/2 = 4
			local foot1 = "Coplands OS Enterprise"
			local foot2 = "Produced by Tachibana Lab"

			-- Footer
			dashboard.section.footer.val = {
				clock,
				date,
				"",
				string.rep(" ", (row_len - string.len(foot1)) / 2 + 1) .. foot1, -- centering
				string.rep(" ", (row_len - string.len(foot2)) / 2 + 1) .. foot2,
				"",
				plugins_loaded,
			}
			dashboard.section.footer.opts.hl = {
				{ { "AlphaFooterGray", 0, -1 } }, -- 2d array for each row indexed from 0 to last -1 col
				{ { "AlphaFooterGray", 0, -1 } },
				{ { "AlphaFooterGray", 0, -1 } },
				{ { "AlphaFooterWhite", 0, -1 } },
				{ { "AlphaFooterWhite", 0, -1 } },
				{ { "AlphaFooterGray", 0, -1 } },
				{ { "AlphaFooterGray", 0, -1 } },
				{ { "AlphaFooterGray", 0, -1 } },
			}
			pcall(vim.cmd.AlphaRedraw)
		end,
	})
end

return M
