local path = "~/.config/nvim/after/plugin/templates/"

-- main.go
vim.api.nvim_create_augroup("main_go_template", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "main.go",
    command = "0r " .. path .. "main.go",
    group = "main_go_template",
})
