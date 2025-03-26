return function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_zathura_check_libsynctex = 1
    vim.g.vimtex_view_zathura_use_synctex = 1
    vim.g.tex_flavor = "latex"
    vim.g.vimtext_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk_engines = {
        _ = "-xelatex", -- set default engine.
    }
    vim.g.vimtex_compiler_latexmk = {
        aux_dir = "./tex/aux",
        out_dir = "./tex/out",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        -- hooks = {},
        options = {
            "-verbose",
            "-file-line-error",
            "-synctex=1",
            "-interaction=nonstopmode",
        },
    }
end
