return function()
	-- VimTeX configuration goes here, e.g.
	vim.g.vimtex_view_method = "zathura"
	vim.g.vimtext_compiler_method = "latexmk"
	vim.g.vimtex_complier_latexmk_engine = {
		_ = "-xelatex", -- set default engine
	}
	vim.g.vimtex_compiler_latexmk = {
		aux_dir = "./aux",
		out_dir = "./out",
		-- callback = 1,
		continuous = 1,
		executable = "latexmk",
		-- hooks = {},
		options = {
			-- '-verbose',
			-- '-file-line-error',
			"-synctex=1",
			"-interaction=nonstopmode",
		},
	}
end
