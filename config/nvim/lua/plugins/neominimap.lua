local M = {}

M.init = function()
    -- The following options are recommended when layout == "float"
    vim.opt.wrap = false
    vim.opt.sidescrolloff = 36 -- Set a large value

    --- Put your configuration here
    ----@type Neominimap.UserConfig
    vim.g.neominimap = {

        auto_enable = true,

        log_level = vim.log.levels.OFF, ---@type Neominimap.Log.Levels

        -- Notification level
        notification_level = vim.log.levels.INFO, ---@type Neominimap.Log.Levels

        -- Path to the log file
        log_path = vim.fn.stdpath("data") .. "/neominimap.log", ---@type string

        -- Minimap will not be created for buffers of these types
        ---@type string[]
        ---
        exclude_filetypes = {
            "help",
            "bigfile", -- For Snacks.nvim
        },

        -- Minimap will not be created for buffers of these types
        ---@type string[]
        exclude_buftypes = {
            "nofile",
            "nowrite",
            "quickfix",
            "terminal",
            "prompt",
        },

        -- When false is returned, the minimap will not be created for this buffer
        ---@type fun(bufnr: integer): boolean
        buf_filter = function()
            return true
        end,

        -- When false is returned, the minimap will not be created for this window
        ---@type fun(winid: integer): boolean
        win_filter = function()
            return true
        end,

        -- How many columns a dot should span
        x_multiplier = 8, ---@type integer

        -- How many rows a dot should span
        y_multiplier = 1, ---@type integer

        ---@alias Neominimap.Config.LayoutType "split" | "float"

        --- Either `split` or `float`
        --- When layout is set to `float`,
        --- the minimap will be created in floating windows attached to all suitable windows
        --- When layout is set to `split`,
        --- the minimap will be created in one split window
        layout = "float", ---@type Neominimap.Config.LayoutType

        --- Used when `layout` is set to `float`
        float = {
            minimap_width = 8, ---@type integer

            --- If set to nil, there is no maximum height restriction
            --- @type integer
            max_minimap_height = 30,

            margin = {
                right = 0, ---@type integer
                top = 0, ---@type integer
                bottom = 0, ---@type integer
            },
            z_index = 1, ---@type integer

            --- Border style of the floating window.
            --- Accepts all usual border style options (e.g., "single", "double")
            --- @type string | string[] | [string, string][]
            window_border = "single",
        },

        -- For performance issue, when text changed,
        -- minimap is refreshed after a certain delay
        -- Set the delay in milliseconds
        delay = 400, ---@type integer

        -- Sync the cursor position with the minimap
        sync_cursor = true, ---@type boolean

        click = {
            -- Enable mouse click on minimap
            enabled = true, ---@type boolean
            -- Automatically switch focus to minimap when clicked
            auto_switch_focus = false, ---@type boolean
        },

        diagnostic = {
            enabled = true, ---@type boolean
            severity = vim.diagnostic.severity.WARN, ---@type vim.diagnostic.SeverityInt
            mode = "line", ---@type Neominimap.Handler.Annotation.Mode
            priority = {
                ERROR = 100, ---@type integer
                WARN = 90, ---@type integer
                INFO = 80, ---@type integer
                HINT = 70, ---@type integer
            },
            icon = {
                ERROR = "󰅚 ", ---@type string
                WARN = "󰀪 ", ---@type string
                INFO = "󰌶 ", ---@type string
                HINT = " ", ---@type string
            },
        },

        git = {
            enabled = true, ---@type boolean
            mode = "sign", ---@type Neominimap.Handler.Annotation.Mode
            priority = 6, ---@type integer
            icon = {
                add = "+ ", ---@type string
                change = "~ ", ---@type string
                delete = "- ", ---@type string
            },
        },

        search = {
            enabled = false, ---@type boolean
            mode = "line", ---@type Neominimap.Handler.Annotation.Mode
            priority = 20, ---@type integer
            icon = "󰱽 ", ---@type string
        },

        treesitter = {
            enabled = true, ---@type boolean
            priority = 200, ---@type integer
        },

        mark = {
            enabled = true, ---@type boolean
            mode = "icon", ---@type Neominimap.Handler.Annotation.Mode
            priority = 10, ---@type integer
            key = "m", ---@type string
            show_builtins = false, ---@type boolean -- shows the builtin marks like [ ] < >
        },

        winopt = function(opt, winid)
            opt.signcolumn = "yes:1"
            opt.number = false
            opt.winblend = 30
            opt.cursorline = true
            -- opt.spell = false
            -- opt.list = false
            -- opt.fillchars = "eob: "
            -- opt.winfixwidth = true
            -- opt.relativenumber = true
            -- opt.scrolloff = 99999 -- To center minimap
            -- opt.sidescrolloff = 0
        end,
    }
end
return M
