local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local function read_theme(name) -- read assii art from text file
	local lines = {}
	local home = os.getenv("HOME")
	local file = io.open(home .. "/.config/nvim/lua/plugins/themes/" .. name, "r") -- text file here
	if not file then
		return { "Couldn't find ascii art path" }
	end
	for line in file:lines() do
		table.insert(lines, line)
	end
	file:close()
	return lines
end

--------------
--- Colors ---
--------------

vim.api.nvim_set_hl(0, "AlphaFooterWhite", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "AlphaFooterGray", { fg = "#999999" })
vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#5fd6fa" })

-- local header = {
-- 	"   █████          ███  █████████████████████████████████████████████████     ",
-- 	" ███████████████████████████████████████████████████████████████████████████ ",
-- 	"█████████████████████████████████████████████████████████████████████████████",
-- 	"█████████████████████████████████████████████████████████████████████████████",
-- 	"█████████████████████████████████████████████████████████████████████████████",
-- 	"█████████████████████████████████████████████████████████████████████████████",
-- 	" ████████████████████████████████████████████████████████████████████████████",
-- 	" ███████████████████████████████████████████████████████████████████████████ ",
-- 	" ███████████████████████████████████████████████████████████████████████████ ",
-- 	" ███████████████████████████████████████████████████████████████████████████ ",
-- 	" ███████████████████████████████████████████████████████████████████████████ ",
-- 	" ███████████████████████████████████████████████████████████████████████████ ",
-- 	"  ██████████████████████████████████████████████████████████████████████████ ",
-- 	"  ██████████████████████████████████████████████████████████████████████████ ",
-- 	"  ███████████████████████████████████████████████████████████████████████████",
-- 	" ████████████████████████████████████████████████████████████████████████████",
-- 	" ████████████████████████████████████████████████████████████████████████████",
-- 	" ████████████████████████████████████████████████████████████████████████████",
-- 	"  ██████████████████████████████████████████████████████████████████████████ ",
-- 	"   █████████████████████████████████████████     ██████████████    ████████  ",
-- }
-- local color_map = {
-- 	"---BBBBB----------BBB--BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB-----",
-- 	"-BBBYYYYBBBBBBBBBB...BB..........BBDDDPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPBPPBBBB-",
-- 	"BBBYYYYYYYYYYBPBB................BDDDPPPPBPPPBBBBBBBBBBBBBBBBBBBBBBPPBBPPPPBB",
-- 	"BBBYYYYYYYYYYYBB..................BBPPPPPPPBB......................BBPPPPPPBB",
-- 	"BBBYYYYYYYYYYYYYBBBBBBBB............BBPPPPB..BBB..B...BBB.BBB.B..B...BPPPPPBB",
-- 	"BBBYYYYYYYYYYYYYYYYYYYYYBB...BBBB....BPPPB...B..B.B...B...B...B..B....BPPPPBB",
-- 	"-BBYYYYYYYYYYYYYYBBBBBBYYYBBB....B...BDPBB...BBB..B...BBB.BBB.BBBB.....BPPBBB",
-- 	"-BBBYYYYYYYYYYYBB......BBYYYB.BB.B.BBDDDB....B..B.B...B...B...B..B.....BPPBB-",
-- 	"-BBBB...YYYYYYB.....BBB..BBYB....B.BDDDDBB...BBB..BBB.BBB.BBB.B..B...BBPPPBB-",
-- 	"-BBPB....YYYYYBB........BBBBBBBBB.BDDDBB...........................BBPPPPPBB-",
-- 	"-BBPPB..........BBBBBBBBB..B....B..BBDDBBBBBBBBBBB...........BBBBBBPPPPPPPBB-",
-- 	"-BBBBB...........BB..BB.BBBBB...B....BDDPPPPPPPPPPBBBBBBBBBBBPPPPPPPPPPPPPBB-",
-- 	"--BB..............B.BBBBBBBBBB..B..BBBDDDPPPPBPPPPPPPPPPPPPPPPPPBBBPPPPPPPBB-",
-- 	"--BBB............B----------B..B..BDDDDDDPPPBBBPPPPPPPPPPPPPPPPPPBPPPPPPPPBB-",
-- 	"--BBPB..........B.BBBBBBBBBB..B..BDDDDDDDPPPPBPPPPPPPPPPPPPPPPPPPPPPPPPPPPBBB",
-- 	"-BBPPPBBB..................BBB...BDDDPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPBB",
-- 	"-BBPPPPPPBBBB......BBBBBBBBDDDBBBDDDDPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPBB",
-- 	"-BBPPPPPPPPBBBBBBBB..BGGGGBDDDDDPDDDDPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPBB",
-- 	"--BBPPPPPPBBGGGGGGGBBGGGGGGBDDDDPPPPPPPPPPPPBBBBBPPPPPPPPPPPPPPBBBBPPPPPPPBB-",
-- 	"---BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB-----BBBBBBBBBBBBBB----BBBBBBBB--",
-- }

local header = read_theme("coplands.txt")
local color_map = read_theme("coplands_colors.txt")

local color_codes = {
	["-"] = { fg = "#ff0000" }, -- Empty (Red)
	-- ["B"] = { fg = "#000000" }, -- Black
	["G"] = { fg = "#555555" }, -- Gray (kind of)
	-- ["."] = { fg = "#ffffff" }, -- White
	-- ["Y"] = { fg = "#ffff00" }, -- Yellow
	-- ["P"] = { fg = "#ff00ff" }, -- Puple
	-- ["D"] = { fg = "#550055" }, -- Dark purple
	["X"] = { fg = "#999999" },
}

local function getLen(str, start_pos)
	local byte = string.byte(str, start_pos)
	if not byte then
		return nil
	end
	return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
end

local function colorize(_header, _header_color_map, _colors)
	for letter, color in pairs(_colors) do
		local color_name = "AlphaHeader" .. letter
		vim.api.nvim_set_hl(0, color_name, color)
		_colors[letter] = color_name
	end

	local colorized = {}

	for i, line in ipairs(_header_color_map) do
		local colorized_line = {}
		local pos = 0

		for j = 1, #line do
			local start = pos
			pos = pos + getLen(_header[i], start + 1)

			local color_name = _colors[line:sub(j, j)]
			if color_name then
				table.insert(colorized_line, { color_name, start, pos })
			end
		end

		table.insert(colorized, colorized_line)
	end

	return colorized
end

dashboard.section.header.val = header
dashboard.section.header.opts = {
	hl = colorize(header, color_map, color_codes),
	position = "center",
}

local buttons = {
	-- { type = "text", val = "Quick links", opts = { hl = "buttons1", position = "center" } },
	dashboard.button("i", " New Fie", ":ene <BAR> startinsert <cr>"),
	dashboard.button("r", " Recent Files", ":Telescope oldfiles<cr>"),
	dashboard.button("<leader>ff", " File Browser", "<Cmd>NvimTreeToggle<CR>"),
	dashboard.button("e", "󰈞 Find File", ":Telescope find_files<cr>"),
	dashboard.button("c", " Colorschemes", ":Telescope colorscheme<cr>"),
	dashboard.button("q", " Exit Vim", ":q<cr>"),
}

-- show table of options command:
-- :lua print(vim.inspect(require("alpha.themes.dashboard").button("c", " Colorschemes", ":Telescope colorscheme<cr>")))

for key, _ in ipairs(buttons) do
	buttons[key].opts.hl_shortcut = "AlphaButtons" -- rhs colors
	buttons[key].opts.hl = "AlphaButtons" -- lhs colors
	buttons[key].opts.width = 35 -- number of columns width
	buttons[key].opts.cursor = 17 -- number of columns width
end

dashboard.section.buttons.val = buttons

-- dashboard.config.layout = {
-- 	{ type = "padding", val = 2 },
-- 	dashboard.section.header,
-- 	{ type = "padding", val = 2 },
-- 	dashboard.section.buttons,
-- 	-- {
-- 	-- 	type = "group",
-- 	-- 	val = {
-- 	-- 		{
-- 	-- 			type = "group",
-- 	-- 			val = {
-- 	-- 				{
-- 	-- 					type = "text",
-- 	-- 					val = "📅 Tasks for today",
-- 	-- 					opts = { hl = "Keyword", position = "center" },
-- 	-- 				},
-- 	-- 				dashboard.section.tasks,
-- 	-- 			},
-- 	-- 			opts = { spacing = 1 },
-- 	-- 		},
-- 	-- 	},
-- 	-- 	opts = {
-- 	-- 		layout = "horizontal",
-- 	-- 	},
-- 	-- },
-- 	{ type = "padding", val = 2 },
-- 	dashboard.section.footer,
-- }

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

alpha.setup(dashboard.config)

-- Set footer
-- Draw Footer After Startup

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
			{ { "AlphaFooterGray", 0, -1 } }, -- 2d array for each row
			{ { "AlphaFooterGray", 0, -1 } }, -- NOTE: this colors each line from index 0 to -1 (last val) as AlphaFooterGray.
			{ { "AlphaFooterGray", 0, -1 } }, -- empty line
			{ { "AlphaFooterWhite", 0, -1 } },
			{ { "AlphaFooterWhite", 0, -1 } },
			{ { "AlphaFooterGray", 0, -1 } }, -- empty line
			{ { "AlphaFooterGray", 0, -1 } },
			{ { "AlphaFooterGray", 0, -1 } },
		}
		pcall(vim.cmd.AlphaRedraw)
	end,
})
