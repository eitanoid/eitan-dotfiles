vim.keymap.set("n", "<leader>im", "<Cmd>PromptLatexMatrix<CR>", { desc = "Prompt for Matrix" })
vim.keymap.set("n", "<leader>ic", "<Cmd>PromptLatexCycle<CR>", { desc = "Prompt for Cycle" })
vim.keymap.set("n", "<leader>il", "<Cmd>PromptLatexList<CR>", { desc = "Prompt for List" })

-- greek letters
vim.keymap.set("i", ";;", ";") --makes it not annoying to type ;

vim.keymap.set("i", ";a", "\\alpha")
vim.keymap.set("i", ";A", "\\Alpha")

vim.keymap.set("i", ";b", "\\beta")
vim.keymap.set("i", ";B", "\\Beta")

vim.keymap.set("i", ";d", "\\delta")
vim.keymap.set("i", ";D", "\\Delta")

vim.keymap.set("i", ";g", "\\gamma")
vim.keymap.set("i", ";G", "\\Gamma")

-- vim.keymap.set("i", ";p", "\\pi")
-- vim.keymap.set("i", ";P", "\\Pi")
--
-- vim.keymap.set("i", ";p", "\\psi")
-- vim.keymap.set("i", ";P", "\\Psi")
--
-- vim.keymap.set("i", ";p", "\\phi")
-- vim.keymap.set("i", ";P", "\\Phi")
--
-- vim.keymap.set("i", ";p", "\\psi")
-- vim.keymap.set("i", ";P", "\\Psi")

vim.keymap.set("i", ";e", "\\varepsilon")
