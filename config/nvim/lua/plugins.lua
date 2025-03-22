-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--require("config.lazy")
-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--  You can press `?` in this menu for help. Use `:q` to close the window
--  To update plugins you can run
--    :Lazy update
--
--
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({

    -- Keybind manager
    {
        "folke/which-key.nvim",
        event = "VeryLazy", -- Sets the loading event to 'VimEnter'
        opts = require("plugins.which-key").opts,
        sort = require("plugins.which-key").sorter, -- TODO: not working, read someone else's which-key documentation
    },

    ------------------
    --- Dashboards ---
    ------------------

    {
        "goolord/alpha-nvim",
        -- dependencies = { 'echasnovski/mini.icons' },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "BufEnter",
        config = require("plugins.alpha").config --[[ require("plugins.alpha_colored_animation").config, ]],
        -- available: devicons, mini, default is mini
        -- if provider not loaded and enabled is true, it will try to use another provider
    },

    {
        "rktjmp/lush.nvim",
        event = "VeryLazy",
    },

    -----------
    --- git ---
    -----------
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },

    { "tpope/vim-fugitive", event = "SafeState" },

    { "tpope/vim-rhubarb", event = "SafeState" },
    --
    { -- proper merge editor
        --- @see documentation at https://github.com/sindrets/diffview.nvim
        "sindrets/diffview.nvim",
        event = "SafeState",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Detect tabstop and shiftwidth automatically, including stuff like modeline
    { "tpope/vim-sleuth", event = "BufEnter" },

    ---------------------------------
    --- Editor Behaviour Features ---
    ---------------------------------

    {
        "Isrothy/neominimap.nvim",
        version = "v3.*.*",
        enabled = true,
        lazy = false, -- NOTE: NO NEED to Lazy load

        keys = require("plugins.neominimap").keys,
        init = require("plugins.neominimap").init,
    },

    -- lualine statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
    },

    -- directory tree
    {
        "nvim-tree/nvim-tree.lua",
        priority = 900, -- we want this loaded pretty much immediately
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = require("plugins.nvim-tree"),
        keys = {},
    },

    -- tabs in neovim
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
            icons = {
                -- Configure the base icons on the bufferline.
                -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
                buffer_index = false,
                buffer_number = true,
                button = "x",
            },
        },
    },

    { -- enables folds
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = "BufReadPre",
        keys = {
            {
                "zR",
                function()
                    require("ufo").openAllFolds()
                end,
            },
            {
                "zM",
                function()
                    require("ufo").closeAllFolds()
                end,
            },
            {
                "K",
                function()
                    local winid = require("ufo").peekFoldedLinesUnderCursor()
                    if not winid then
                        vim.lsp.buf.hover()
                    end
                end,
            },
        }, --TODO: automatically folds all my tex stuff
        config = function()
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }
            local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
            for _, ls in ipairs(language_servers) do
                require("lspconfig")[ls].setup({
                    capabilities = capabilities,
                    -- you can add other fields for setting up lsp server in this table
                })
            end
            require("ufo").setup()
        end,
    },

    { -- nicer looking Markdown
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "html" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },

    -----------------------------
    --- Work i.e TeX Ajdacent ---
    -----------------------------

    { -- latex plugins
        "lervag/vimtex",
        ft = { "latex", "tex", "bib" },
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = require("plugins.vimtex")(),
        dependencies = { "micangl/cmp-vimtex" }, -- completions support for vimtex
    },

    -- quarto configuration
    require("plugins.quarto"),

    -- Send to terminal / code runner
    require("plugins.slime"),

    ---------------------
    --- Functionality ---
    ---------------------

    { -- todo later -- repeat keybinds and hint menus
        "anuvyklack/hydra.nvim",
        event = "BufEnter",
    },

    { -- Fuzzy Finder (files, lsp, etc)
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                "nvim-telescope/telescope-fzf-native.nvim",

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = "make",

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        config = require("plugins.telescope"),
    },

    --------------------------
    --- Diagnostic Plugins ---
    --------------------------
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000, -- needs to be loaded in first
        config = function()
            require("plugins.tiny-inline-diagnostic").setup()
        end,
    },

    {
        "folke/trouble.nvim",
        opts = require("plugins.trouble").opts,
        cmd = require("plugins.trouble").cmd,
        keys = require("plugins.trouble").keys,
    },

    -------------------
    --- LSP Plugins ---
    -------------------

    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },

    { "Bilal2453/luvit-meta", lazy = true },

    {
        -- Main LSP Configuration
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { "j-hui/fidget.nvim", opts = {}, lazy = true },

            -- Allows extra capabilities provided by nvim-cmp
            "hrsh7th/cmp-nvim-lsp",
        },
        config = require("plugins.lsp-config"),
    },

    { -- Autoformat
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        opts = require("plugins.conform").opts,
    },

    { -- Autocompletion
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- completion sources
            "saadparwaiz1/cmp_luasnip",
            "petertriho/cmp-git", -- Git
            "hrsh7th/cmp-nvim-lsp", -- lsp completions
            "hrsh7th/cmp-path", -- path competions
            "hrsh7th/cmp-omni", -- Neovim Omnifunc
            "kdheepak/cmp-latex-symbols", -- LaTeX Letters
            "Snikimonkd/cmp-go-pkgs", -- golang packages

            -- Snippet Engine & its associated nvim-cmp source
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    -- {
                    --   'rafamadriz/friendly-snippets',
                    --   config = function()
                    --     require('luasnip.loaders.from_vscode').lazy_load()
                    --   end,
                    -- },
                },
            },
        },
        config = require("plugins.nvim-cmp"),
    },

    --------------------
    --- Color Scheme ---
    --------------------

    {
        "folke/tokyonight.nvim",
        priority = 1000, -- Make sure to load this before all the other start plugins.
        init = function()
            vim.cmd.colorscheme("tokyonight-moon")
            -- vim.cmd.colorscheme("onedark")
            -- You can configure highlights by doing something like:
            vim.cmd.hi("Comment gui=none")
        end,
    },

    -------------------
    --- misc plugins---
    -------------------

    -- Tabular plugin (Vim plugin for aligning text with delimiters) :Tabular command
    { "godlygeek/tabular", lazy = true },

    -- color preview eg.
    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = { -- set to setup table
            user_default_options = { names = true },
            buftypes = {
                "*",
                "!prompt",
                "!opoup",
                "!lazy",
            },
        },
    },

    -- Comment plugin `gc` motion
    { "numToStr/Comment.nvim", opts = {} },
    --
    -- self explanatory, raindow brackets etc
    { "HiPhish/rainbow-delimiters.nvim" },

    -- closes pairs automatically
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            enable_check_bracket_line = false,
        },
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")
            -- local cond = require("nvim-autopairs.conds")

            npairs.setup({})

            npairs.add_rules({
                Rule("$", "$", "tex"),
            })
        end,
    },

    { -- indent guides
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },

    -- Highlight todo, notes, etc in comments
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },

    { -- Collection of various small independent plugins/modules
        "echasnovski/mini.nvim",
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
            --  - ci'  - [C]hange [I]nside [']quote
            require("mini.ai").setup({ n_lines = 500 })

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require("mini.surround").setup({
                -- Add custom surroundings to be used on top of builtin ones. For more
                -- information with examples, see `:h MiniSurround.config`.
                custom_surroundings = nil,

                -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
                highlight_duration = 500,

                -- Module mappings. Use `''` (empty string) to disable one.
                mappings = {
                    add = "sa", -- Add surrounding in Normal and Visual modes
                    delete = "sd", -- Delete surrounding
                    find = "sf", -- Find surrounding (to the right)
                    find_left = "sF", -- Find surrounding (to the left)
                    highlight = "sh", -- Highlight surrounding
                    replace = "sr", -- Replace surrounding
                    update_n_lines = "sn", -- Update `n_lines`
                    suffix_last = "l", -- Suffix to search with "prev" method
                    suffix_next = "n", -- Suffix to search with "next" method
                },

                -- Number of lines within which surrounding is searched
                n_lines = 20,

                -- Whether to respect selection type:
                -- - Place surroundings on separate lines in linewise mode.
                -- - Place surroundings on each line in blockwise mode.
                respect_selection_type = false,

                -- How to search for surrounding (first inside current line, then inside
                -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
                -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
                -- see `:h MiniSurround.config`.
                search_method = "cover",

                -- Whether to disable showing non-error feedback
                -- This also affects (purely informational) helper messages shown after
                -- idle time if user input is required.
                silent = false,
            })

            -- Simple and easy statusline.
            --  You could remove this setup call if you don't like it,
            --  and try some other statusline plugin
            local statusline = require("mini.statusline")
            -- set use_icons to true if you have a Nerd Font
            statusline.setup({ use_icons = vim.g.have_nerd_font })

            -- You can configure sections in the statusline by overriding their
            -- default behavior. For example, here we set the section for
            -- cursor location to LINE:COLUMN
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return "%2l:%-2v"
            end

            -- ... and there is more!
            --  Check out: https://github.com/echasnovski/mini.nvim
        end,
    },

    ------------------
    --- treesitter ---
    ------------------
    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        event = "BufEnter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs", -- Sets main module to use for opts
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        opts = require("plugins.nvim-treesitter").opts,
        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        --
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    },

    -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. If you want these files, they are in the repository, so you can just download them and
    -- place them in the correct locations.

    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
    --
    --  Here are some example plugins that I've included in the Kickstart repository.
    --  Uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    -- require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',
    -- require 'kickstart.plugins.lint',
    -- require 'kickstart.plugins.autopairs',
    -- require 'kickstart.plugins.neo-tree',
    -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    -- { import = "plugins" },
    --
    -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
    -- Or use telescope!
    -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
    -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: set ts=2 sw=2 noet
