return function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
    vim.g.tex_flavor = "latex"
    vim.g.vimtext_compiler_method = "latexmk"
    vim.g.vimtex_complier_latexmk_engine = {
        _ = "-xelatex", -- set default engine and it's not doing anything.
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
