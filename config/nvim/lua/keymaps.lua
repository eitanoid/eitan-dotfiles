-- just copying from init.lua rn

-- Set <space> as the leader key
-- See `:help mapleader`
--
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
--vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
--
-- TEMPORARY TO TURN INTO CONDITIONAL IMPORT

-- Diagnostic keymaps
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
--vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setqflist()<CR>", { desc = "Display diagnostics" })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.

----------------------------------------------------------------

----------------------------------------------------------------

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Clear highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Buffer Keymaps
vim.keymap.set("n", "<A-l>", "<Cmd>bnext<CR>", { desc = "Next Buffer (Tab)" })
vim.keymap.set("n", "<A-S-h>", "<Cmd>bnext<CR>", { desc = "Next Buffer (Tab)" })
vim.keymap.set("n", "<A-S-l>", "<Cmd>bprevious<CR>", { desc = "Previous Buffer (Tab)" })
vim.keymap.set("n", "<A-h>", "<Cmd>bprevious<CR>", { desc = "Previous Buffer (Tab)" })

vim.keymap.set("n", "<C-`>", function()
    vim.wo.relativenumber = not vim.wo.relativenumber
end, { noremap = true, desc = "toggle relative numbers" })

-- keep indent in visual mode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Edit keymaps for binds I might forget
vim.keymap.set("n", "<leader>e%", "%", { desc = "Move to Matching Delimiter - %" })
vim.keymap.set("n", "<leader>eyi", "yi", { desc = "Yank Text Inside Next Delimiter" })
vim.keymap.set("n", "<leader>e>", ">", { desc = "Indent Forwards" })
vim.keymap.set("n", "<leader>e<", "<", { desc = "Indent Backwards" })
vim.keymap.set("n", "<leader>/", "gcc", { desc = "Toggle Comment" })

-- Cool thing I saw in a vimtex video skip to next instance of (<>) and remove it.
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

vim.keymap.set("n", "<leader><leader>", "<Cmd>JumpToPlaceholder<CR>", { desc = "Jump to next occurence of (<>) and enter insert mode" })

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
        vim.cmd("normal ciw" .. case[word]) -- swaps
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
            { "<leader>h", group = "Git Hunk", mode = { "n", "v" } },
            { "<leader>e", group = "Edit" },
            { "<leader>l", group = "LaTeX" },
            { "<leader>h", group = "Hydra" },
            { "<leader>i", group = "Insert" },
        })
        ---------------
        --- Minimap ---
        ---------------

        wk.add({
            mode = { "n" },
            { "<leader>m", group = "[M]iniMap" },
            -- Global Minimap Controls
            { "<leader>mm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
            { "<leader>mo", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
            { "<leader>mc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
            { "<leader>mr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },

            -- Window-Specific Minimap Controls
            { "<leader>mwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
            { "<leader>mwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
            { "<leader>mwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
            { "<leader>mwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },

            -- Tab-Specific Minimap Controls
            { "<leader>mtt", "<cmd>Neominimap tabToggle<cr>", desc = "Toggle minimap for current tab" },
            { "<leader>mtr", "<cmd>Neominimap tabRefresh<cr>", desc = "Refresh minimap for current tab" },
            { "<leader>mto", "<cmd>Neominimap tabOn<cr>", desc = "Enable minimap for current tab" },
            { "<leader>mtc", "<cmd>Neominimap tabOff<cr>", desc = "Disable minimap for current tab" },

            -- Buffer-Specific Minimap Controls
            { "<leader>mbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
            { "<leader>mbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
            { "<leader>mbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
            { "<leader>mbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },

            ---Focus Controls
            { "<leader>mf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
            { "<leader>mu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
            { "<leader>ms", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
        })

        -----------------
        --- Terminals ---
        -----------------

        local function new_terminal(lang)
            vim.cmd("vsplit term://" .. lang)
        end

        local function new_terminal_python()
            new_terminal("python")
        end

        local function new_terminal_r()
            new_terminal("R --no-save")
        end

        local function new_terminal_ipython()
            new_terminal("ipython --no-confirm-exit")
        end

        local function new_terminal_julia()
            new_terminal("julia")
        end

        local function new_terminal_shell()
            new_terminal("$SHELL")
        end

        wk.add({
            { "<leader>c", group = "[c]ode / [c]ell / [c]hunk" },
            { "<leader>ci", new_terminal_ipython, desc = "new [i]python terminal" },
            { "<leader>cj", new_terminal_julia, desc = "new [j]ulia terminal" },
            { "<leader>cn", new_terminal_shell, desc = "[n]ew terminal with shell" },
            { "<leader>cp", new_terminal_python, desc = "new [p]ython terminal" },
            { "<leader>cr", new_terminal_r, desc = "new [R] terminal" },
            -- { "<C-c><C-c>", ":SlimeSend<cr>" },
            -- { "<leader>cc", ":SlimeSend<cr>" },
        })

        ----------------------
        --- Quatro Actions ---
        ----------------------

        -- mostly copied from https://github.com/jmbuhr/quarto-nvim-kickstarter

        -- Show R dataframe in the browser
        -- might not use what you think should be your default web browser
        -- because it is a plain html file, not a link
        -- see https://askubuntu.com/a/864698 for places to look for

        -- only load settings in a Quarto file.
        -- TODO: Work in buffer only rather than in neovim globally
        -- vim.api.nvim_create_autocmd("FileType", {
        -- 	pattern = "quarto",
        -- 	callback = function()
        local is_code_chunk = function()
            local current, _ = require("otter.keeper").get_current_language_context()
            if current then
                return true
            else
                return false
            end
        end

        --- Insert code chunk of given language
        --- Splits current chunk if already within a chunk
        --- @param lang string
        local insert_code_chunk = function(lang)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
            local keys
            if is_code_chunk() then
                keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
            else
                keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
            end
            keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
            vim.api.nvim_feedkeys(keys, "n", false)
        end

        local insert_r_chunk = function()
            insert_code_chunk("r")
        end

        local insert_py_chunk = function()
            insert_code_chunk("python")
        end

        local function show_r_table()
            local node = vim.treesitter.get_node({ ignore_injections = false })
            assert(node, "no symbol found under cursor")
            local text = vim.treesitter.get_node_text(node, 0)
            local cmd = [[call slime#send("DT::datatable(]] .. text .. [[)" . "\r")]]
            vim.cmd(cmd)
        end
        -- 	end,
        -- })
        -- TODO: make this only load when Quarto, R or Python are loaded?
        -- Quatro settings
        wk.add({
            cond = function()
                return vim.o.ft == "quarto" or vim.o.ft == "qmd"
            end,

            { "<leader>Q", group = "[Q]uarto" },

            { "<leader>Qa", ":QuartoActivate<cr>", desc = "[a]ctivate" },
            { "<leader>Qe", require("otter").export, desc = "[e]xport" },
            { "<leader>Qh", ":QuartoHelp ", desc = "[h]elp" },
            { "<leader>Qp", ":lua require'quarto'.quartoPreview()<cr>", desc = "[p]review" },
            { "<leader>Qq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "[q]uiet preview" },

            { "<leader>Qr", group = "[r]un" },
            { "<leader>Qra", ":QuartoSendAll<cr>", desc = "run [a]ll" },
            { "<leader>Qrb", ":QuartoSendBelow<cr>", desc = "run [b]elow" },
            { "<leader>Qrr", ":QuartoSendAbove<cr>", desc = "to cu[r]sor" },

            { "<leader>r", group = "[r] R specific tools" },
            { "<leader>rt", show_r_table, desc = "show [t]able" },

            {
                "<leader>QE",
                function()
                    require("otter").export(true)
                end,
                desc = "[E]xport with overwrite",
            },

            { "<m-p>", insert_py_chunk, desc = "python code chunk" }, -- Meta i.e Alt
            { "<m-r>", insert_r_chunk, desc = "r code chunk" },
        })

        ---------------------------
        --- Trouble Diagnostics ---
        ---------------------------

        wk.add({
            { "<leader>q", group = "Diagnostics" },

            { "<leader>qx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },

            { "<leader>qX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>qs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
            {
                "<leader>ql",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            { "<leader>qL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>qQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
        })

        --- Buffers ---
        ---
        ---
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
            { "<leader>f", group = "[F]ile Tree" },
            { "<leader>ff", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
            { "<leader>fh", require("nvim-tree.api").tree.change_root_to_parent(), desc = "Change Root to Parent" },
            { "<leader>fl", require("nvim-tree.api").tree.change_root_to_node(), desc = "Change Root to Node" },
            { "<leader>fE", require("nvim-tree.api").tree.expand_all(), desc = "Expand All" },
            { "<leader>fC", require("nvim-tree.api").tree.collapse_all(), desc = "Collapse All" },
            { "<leader>fp", require("nvim-tree.api").fs.copy.absolute_path(), desc = "Copy Absolute Path" },
            { "<leader>fP", require("nvim-tree.api").fs.copy.relative_path(), desc = "Copy Relative Path" },
            { "<leader>fn", require("nvim-tree.api").fs.create(), desc = "New File / Directory" },
            { "<leader>fr", require("nvim-tree.api").fs.rename(), desc = "Rename File" },
        })
    end,
})
-- vim.keymap.set("n", "<leader>ff", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle file tr[ee]" })
