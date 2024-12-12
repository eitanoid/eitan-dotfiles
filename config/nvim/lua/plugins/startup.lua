local settings = {
	--
	--
	-- every line should be same width without escaped \
	header = {
		type = "text",
		align = "center",
		fold_section = false,
		title = "Header",
		margin = 0,
		content = function() -- read assii art from text file
			local lines = {}
			local home = os.getenv("HOME")
			local file = io.open(home .. "/.config/nvim/lua/plugins/coplands.txt", "r") -- text file here
			if not file then
				return { "Couldn't find ascii art path" }
			end
			for line in file:lines() do
				table.insert(lines, line)
			end
			file:close()
			return lines
		end,

		highlight = "StartupHeader1",
		default_color = "",
		oldfiles_amount = 5,
	},

	header_2 = {
		type = "text",
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "Quote",
		margin = 1,
		content = { "No matter where you go, everyone's connected." },
		highlight = "StartupHeader2",
		default_color = "",
		oldfiles_amount = 0,
	},
	-- name which will be displayed and command
	body = {
		type = "mapping",
		align = "center",
		fold_section = false,
		title = "Select An Option:",
		margin = 2,
		content = {
			{ " New Fie", "ene", "i" },
			{ " Recent Files", "Telescope oldfiles", "r" },
			{ " File Browser", "NvimTreeToggle ", "f" },
			{ "󰈞 Find File", "Telescope find_files", "e" },
			{ " Colorschemes", "Telescope colorscheme", "c" },
			{ " Exit Vim", "q", "q" },
			-- { "󰍉 Find Word", "Telescope live_grep", "<leader>lg" },
		},

		highlight = "StartupBody",
		default_color = "",
		oldfiles_amount = 0,
	},
	body_2 = {
		type = "oldfiles",
		oldfiles_directory = true,
		align = "center",
		fold_section = true,
		title = "Oldfiles of Directory",
		margin = 1,
		content = {},
		highlight = "StartupBody2",
		default_color = "#FFFFFF",
		oldfiles_amount = 5,
	},
	footer = {
		type = "oldfiles",
		oldfiles_directory = false,
		align = "center",
		fold_section = true,
		title = "Oldfiles",
		margin = 1,
		content = { "startup.nvim" },
		highlight = "StartupFooter",
		default_color = "#FFFFFF",
		oldfiles_amount = 5,
	},

	clock = {
		type = "text",
		content = function()
			local clock = " " .. os.date("%H:%M")
			local date = " " .. os.date("%d-%m-%y")
			return { clock, date }
		end,
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "",
		margin = 1,
		highlight = "StartupClock",
		default_color = "#FFFFFF",
		oldfiles_amount = 10,
	},

	footer_2 = {
		type = "text",
		content = { "Coplands OS Enterprise", "Produced by Tachibana Lab" },
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "",
		margin = 2,
		highlight = "StartupFooter2",
		default_color = "#FFFFFF",
		oldfiles_amount = 10,
	},
	options = {
		after = function()
			require("startup.utils").oldfiles_mappings()
			-- vim.cmd("highlight Normal guibg = #242829") -- cursed way of doing colors because I dont undestand how they work
			vim.cmd("highlight StartupHeader1 guifg = #5fd6fa")
			vim.cmd("highlight StartupHeader2 guifg = #999999")
			vim.cmd("highlight StartupBody guifg = #5fd6fa")
			vim.cmd("highlight StartupBody2 guifg = #ffffff")
			vim.cmd("highlight StartupFooter guifg = #ffffff")
			vim.cmd("highlight StartupFooter2 guifg = #ffffff")
			vim.cmd("highlight StartupClock guifg = #999999")
		end,
		mapping_keys = true,
		cursor_column = 0.5,
		empty_lines_between_mappings = true,
		disable_statuslines = true,
		paddings = { 1, 2, 2, 1, 1, 2, 2 },
	},
	colors = {
		background = "#242829", -- "#1f2227",
		folded_section = "#56b6c2",
	},

	parts = {
		"header",
		"header_2",
		"body",
		-- "body_2",
		-- "footer",
		"clock",
		"footer_2",
	},
}
return settings
