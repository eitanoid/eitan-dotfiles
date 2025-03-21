local M = {}

M.opts = {
	preset = "modern",
	expand = 1, -- expand mapes if there's space
	icons = {
		-- set icon mappings to true if you have a Nerd Font
		mappings = vim.g.have_nerd_font,
		-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
		-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
		keys = vim.g.have_nerd_font and { BS = "<BS> " } or { -- <BS> doesn't work in my font for some reason, added.
			Up = "<Up> ",
			Down = "<Down> ",
			Left = "<Left> ",
			Right = "<Right> ",
			C = "<C-…> ",
			M = "<M-…> ",
			D = "<D-…> ",
			S = "<S-…> ",
			CR = "<CR> ",
			Esc = "<Esc> ",
			ScrollWheelDown = "<ScrollWheelDown> ",
			ScrollWheelUp = "<ScrollWheelUp> ",
			NL = "<NL> ",
			BS = "<BS> ",
			Space = "<Space> ",
			Tab = "<Tab> ",
			F1 = "<F1>",
			F2 = "<F2>",
			F3 = "<F3>",
			F4 = "<F4>",
			F5 = "<F5>",
			F6 = "<F6>",
			F7 = "<F7>",
			F8 = "<F8>",
			F9 = "<F9>",
			F10 = "<F10>",
			F11 = "<F11>",
			F12 = "<F12>",
		},
	},
	sort = { "alphanum", "group" },
}

-- M.sort = { "group", "alphanum", "local", "order", "mod" } -- TODO: figure out how to make this work ]]

return M
