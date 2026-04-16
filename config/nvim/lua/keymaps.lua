local s = { silent = true }

-- navigation
vim.keymap.set("n", "H", "^", { desc = "move to first symbol on the line" })
vim.keymap.set("n", "L", "$", { desc = "move to last symbol on the line" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")    -- clear highlight

vim.keymap.set("n", "<Leader>|", "<cmd>vsplit<CR>", s) -- Split the window vertically
vim.keymap.set("n", "<Leader>-", "<cmd>split<CR>", s)  -- Split the window horizontally

--  See `:help wincmd` for a list of all window commands -- handled by tmux vim navigator now
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Buffer Keymaps
vim.keymap.set("n", "<A-l>", "<Cmd>bnext<CR>", { desc = "Next Buffer (Tab)" })
vim.keymap.set("n", "<A-S-h>", "<Cmd>bnext<CR>", { desc = "Next Buffer (Tab)" })
vim.keymap.set("n", "<A-S-l>", "<Cmd>bprevious<CR>", { desc = "Previous Buffer (Tab)" })
vim.keymap.set("n", "<A-h>", "<Cmd>bprevious<CR>", { desc = "Previous Buffer (Tab)" })

-- keep indent in visual mode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- cool thing I saw in a vimtex video skip to next instance of (<>) and remove it.
vim.api.nvim_create_user_command("JumpToPlaceholder", function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local pattern = "%(%<%>%)"
    local lines = vim.api.nvim_buf_get_lines(0, row - 1, row + 30, false) -- from this row til 30 rows down inclusive
    local p_x

    for p_y, line in pairs(lines) do
        if p_y == 1 then
            if col < 2 then -- if too close to left edge set 0, otherwise remove 2 so curosr at anypoint of placeholder still goes to the same one.
                col = 0
            else
                col = col - 2
            end

            p_x, _ = line:find(pattern, col) -- search after the cursor on current line
        else
            p_x, _ = line:find(pattern)
        end

        if p_x then -- once found pattern
            print(p_x, p_y)
            vim.api.nvim_win_set_cursor(0, { row + p_y - 1, p_x - 1 })
            -- vim.api.nvim_buf_set_lines(0, row-1, row,false,line[]) TODO: use vimapi at some point for this because feedkeys is jank

            vim.api.nvim_feedkeys("v3lc", "n", false) -- select 3 ahead, go into change mode
            break
        end
    end

    print("No instance of (<>) found within 30 lines")
end, {})

vim.keymap.set("n", "<leader><leader>", "<Cmd>JumpToPlaceholder<CR>",
    { desc = "Jump to next occurence of (<>) and enter insert mode" })

vim.api.nvim_create_user_command("FlipBool", function()
    local word = vim.fn.expand("<cword>")
    local case = {
        ["TRUE"] = "FALSE",
        ["True"] = "False",
        ["true"] = "false",
        ["FALSE"] = "TRUE",
        ["False"] = "True",
        ["false"] = "true",
    }
    local row, col = unpack(vim.api.nvim_win_get_cursor(0)) -- curent position
    local line = vim.fn.getline(row)
    local char = line:sub(col + 1, col + 1)

    if not char:match("%a") then -- cursor is on an ascii char and not a word.
        return
    end

    if case[word] then
        vim.cmd("normal ciw" .. case[word])            -- swaps
        local newc = vim.api.nvim_win_get_cursor(0)[2] -- get new col
        if col > newc then
            col = col - 1
        end
        vim.api.nvim_win_set_cursor(0, { row, col })
    end
end, { desc = "Toggle Boolian" })

vim.keymap.set("n", "<C-X>", "<CMD>FlipBool<CR>", { desc = "Toggle Bool Under Cursor" })
vim.keymap.set("n", "<C-A>", "<CMD>FlipBool<CR>", { desc = "Toggle Bool Under Cursor" })

----------------------
--- Which Key Menu ---
----------------------

vim.api.nvim_create_autocmd("User", { -- lazy load keybinds to save like 3ms in loading
    once = true,
    pattern = "VeryLazy",
    callback = function()
        -- Lua Snip:
        -- local opts = { noremap = true, silent = true }
        -- vim.api.nvim_set_keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
        -- vim.api.nvim_set_keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
        -- vim.api.nvim_set_keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
        -- vim.api.nvim_set_keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

        local wk = require("which-key")
        wk.add({
            { "<leader>`", group = "LSP Actions" },
            { "<leader>d", group = "[D]ocument" },
            { "<leader>r", group = "Rename" },
            { "<leader>s", group = "Search" },
            { "<leader>w", group = "Workspace" },
            { "<leader>t", group = "Toggle" },
            { "<leader>h", group = "Git Hunk",   mode = { "n", "v" } },
            { "<leader>e", group = "Edit" },
            { "<leader>l", group = "LaTeX" },
            { "<leader>h", group = "Hydra" },
            { "<leader>i", group = "Insert" },
        })

        ----------------------
        --- Quatro Actions ---
        ----------------------
        -- see https://github.com/jmbuhr/quarto-nvim-kickstarter if I want this again

        --- Buffers ---

        wk.add({
            {
                "<leader>b",
                group = "[b]uffers",
                expand = function()
                    return require("which-key.extras").expand.buf()
                end,
            },
        })

        -- Nvim-Tree
        wk.add({
            mode = { "n" }, -- TODO: Not entirely working
            { "<leader>f",  group = "[F]ile Tree" },
            { "<leader>f",  group = "[F]ile Tree" },
            { "\\",         "<Cmd>NvimTreeToggle<CR>",                           desc = "Toggle file tree" },
            { "<leader>ff", "<Cmd>NvimTreeToggle<CR>",                           desc = "Toggle file tree" },
            { "<leader>fh", require("nvim-tree.api").tree.change_root_to_parent, desc = "Change Root to Parent" },
            { "<leader>fl", require("nvim-tree.api").tree.change_root_to_node,   desc = "Change Root to Node" },
            { "<leader>fE", require("nvim-tree.api").tree.expand_all,            desc = "Expand All" },
            { "<leader>fC", require("nvim-tree.api").tree.collapse_all,          desc = "Collapse All" },
            { "<leader>fp", require("nvim-tree.api").fs.copy.absolute_path,      desc = "Copy Absolute Path" },
            { "<leader>fP", require("nvim-tree.api").fs.copy.relative_path,      desc = "Copy Relative Path" },
            { "<leader>fn", require("nvim-tree.api").fs.create,                  desc = "New File / Directory" },
            { "<leader>fr", require("nvim-tree.api").fs.rename,                  desc = "Rename File" },
        })
    end,
})
