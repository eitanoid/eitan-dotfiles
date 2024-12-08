-- alpha-config.lua

local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[              ⡀⡀⡀⣀⣀⣀⡀⡀⡀           ]],
	[[           ⡀⣠⣶⣿⣟⣿⣿⣿⣿⣿⣿⣿⣶⣀         ]],
	[[     ⡀⣀⣀⡀⡀⣴⣿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠛⠛⠿⣿⣷⣄⡀      ]],
	[[   ⢀⣶⣿⠛⠛⢻⣿⣿⣿⣿⣿⣿⠛⡀⡀⡀⡀⣤⣶⣤⣄⡀⠻⣿⣿⣷     ]],
	[[   ⣼⣿⡀⡀⢀⣿⣿⣿⣿⣿⡟⡀⡀⡀⡀⡀⡀⡀⠙⠿⠁⡀⡀⠘⣿⣿⠂    ]],
	[[   ⠸⣿⣷⡀⣿⣿⣿⣿⣿⡿⡀⡀⡀⡀⡀⡀⡀⡀⢀⣀⡀⡀⡀⡀⠈⣿⣷⡀   ]],
	[[    ⠹⣿⣿⣿⣿⣿⣿⣿⠁⡀⡀⡀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣷⣄⡀⢻⣿⡆   ]],
	[[      ⣿⣿⣿⣿⣿⣿⠄⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣌⣿⣿⡀  ]],
	[[     ⢸⣿⣿⣿⣿⣿⣷⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⡀  ]],
	[[     ⣼⣿⣿⣿⣿⢷⣿⣿⣿⣿⣿⣿⡇⡇⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⡀ ]],
	[[     ⣿⣿⣿⣿⣿⣿⣿⣿⢸⡏⣿⣿⡇⡇⡀⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⢹⡀ ]],
	[[     ⣿⣿⣿⣿⣻⣿⣿⣏⣠⠧⠾⠶⠶⠧⡀⡿⣛⡀⣻⣼⣤⣙⢻⣿⣿⡿⡇  ]],
	[[     ⣿⣿⣿⣿⣿⣿⡁⠂⢀⢴⢶⡦⡁⡀⡀⠁⡀⡀⣭⣤⣤⡀⠸⣿⣿⡇⡀  ]],
	[[    ⢐⣿⣿⣿⣿⡀⡀⠇⡀⠉⣌⡿⠣⠔⡀⡀⡀⡀⡀⢀⠿⢟⡁⢰⣿⠉⢸⡀  ]],
	[[    ⢸⣿⣿⣿⣿⣿⣧⠈⡀⡀⡀⡀⡀⡀⡀⡀⢀⡀⡀⡀⡀⡀⡀⡟⡐⣇⢸⡀  ]],
	[[    ⣼⣿⣿⡿⣿⣿⣿⣧⡀⡀⡀⡀⡀⡀⡀⡀⡀⡄⡀⡀⡀⡀⣼⡇⡇⠸⢸⡀  ]],
	[[   ⢀⣿⣿⡿⢸⠈⢿⡟⢿⠳⣄⡀⡀⡀⡀⡀⢀⡀⡀⡀⡀⢀⣼⣿⠅⢕⡣⢻⡆  ]],
	[[   ⣾⣿⡟⣄⡸⢇⡰⢆⡰⢎⡰⠳⣄⡀⡀⡀⡀⡀⡀⣠⡞⠉⣿⣿⡁⡪⢕⢥⢻⡀ ]],
	[[   ⣿⣿⢰⡎⢱⡎⠱⢪⡕⢪⡱⢎⡕⡙⣖⠤⠤⡲⣉⢎⡱⢇⣿⣿⡇⢕⡎⡱⢇⢷⡀]],
	[[   ⣾⣿⢱⡎⢱⡎⢱⡎⢱⡎⢱⡎⠙⣁⣴⣾⣶⢶⣦⡊⢱⢳⢻⣿⡇⡇⢪⢜⡪⢕⡆]],
	[[  ⣾⣿⣿⣄⢜⡣⢜⡣⢜⡣⠜⣡⣾⣿⣿⣿⣿⣥⣾⣿⣿⣷⣤⠘⣿⣿⡪⢕⡸⢕⣺⠁]],
	[[ ⣼⣿⣿⣿⣿⣷⡘⢳⡞⠸⣡⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠕⡪⢅⣴⣆⡀]],
	[[⣰⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄}]],
}
dashboard.section.buttons.val = {
	dashboard.button("f", "󰈞 Find file", ":Telescope find_files <CR>"),
	dashboard.button("i", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("r", " Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("c", "  Dotfiles", "<CMD>!open https://github.com/eitanoid/eitan-dotfiles <CR>"),
	dashboard.button("q", " Quit Neovim", ":qa<CR>"),
}

local function footer()
	return "No matter where you go, everyone's connected."
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
