-- curtosy of / inspired by https://github.com/TomJo2000/.dotfiles/tree/main/.config/nvim/lua/plugins/lualine
local M = {}
-- local theme = {} -- doesn't work rn will fix eventually
-- vim.schedule(function()
--     require("tokyonight").load({ style = "moon" })
--     theme = require("tokyonight.colors").setup()
-- end)
--
local conditions = {
    ---@return boolean
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    ---@return boolean
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    ---@return boolean
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local search_count = function() -- count how many matches are to a search
    local count = vim.fn.searchcount({ maxcount = 0 })
    return count.incomplete > 0 and "?/?" -- unfinished search
        or count.total > 0 and ("🔍%s/%s"):format(count.current, count.total) -- has results
        or ""
end

local get_unicode = function() -- show unicode under cursor
    return ("U+%04X"):format(vim.api.nvim_eval_statusline("%b", {}).str)
end -- tests: 2 digit µ, 3 digit ඞ, 4 digit , 5 digit 󰕰

M.setup = {
    options = {
        theme = "auto",
        always_divide_middle = false,
        globalstatus = true, -- one statusline in each neovim window rather than buffer
        component_separators = " ",
        section_separators = { left = " ", right = " " },
        icons_enabled = true,
        always_show_tabline = true,
        padding = { left = 0, right = 0 },
        refresh = { statusline = 150, tabline = 150, winbar = 150 },
        disabled_filetypes = { -- Filetypes to disable lualine for.
            statusline = {}, -- only ignores the ft for statusline.
            winbar = {}, -- only ignores the ft for winbar.
        },
    },
    -- clear default secitons
    sections = {
        -- lualine_a = {},
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_y = {},
        -- lualine_z = {},
        lualine_x = {},
        -- winbar = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
}

local focused = {}

focused.left = {

    { -- File size (also controls save indicator)
        "filesize",
        cond = conditions.buffer_not_empty,
        padding = {},
    },
    "filetype",
}

focused.right = {
    {
        search_count,
        timeout = 500,
    },

    "diagnostics",

    {
        get_unicode,
        timeout = 500,
        use_mode_colors = true,
    },

    -- -- lualine_a = { "mode" },
    {
        "branch",
        color = { gui = "bold" },
    },
    {
        "diff",
    },
    -- "progress",
    -- "location",
    -- lualine_c = { "filename" },
    -- lualine_x = {
    --     get_unicode,
    -- },
    -- lualine_y = { "progress" },
    -- lualine_z = { "location" },
}

M.setup.sections.lualine_b = focused.left
M.setup.sections.lualine_x = focused.right

--     inactive_sections = {
--         lualine_a = {},
--         lualine_b = {},
--         lualine_c = { "filename" },
--         lualine_x = { "location" },
--         lualine_y = {},
--         lualine_z = {},
--     },
--     tabline = {},
--     inactive_winbar = {},
--     extensions = {},
--     winbar = {
--         lualine_c = {
--             { -- open buffers
--                 "buffers",
--                 icons_enabled = false,
--                 show_modified_status = false,
--                 fmt = function(str, context) -- icons always have a space by default, if we add them ourselves, we can change that.
--                     local icon, _ = require("nvim-web-devicons").get_icon(context.filetype)
--                     return ("%s%s"):format(icon, str)
--                 end,
--                 max_length = 0, -- Maximum width of buffers component,
--                 buffers_color = {
--                     -- active = { fg = "#acacff", bg = "#acacff" }, -- Color for active buffer.
--                 },
--                 filetype_names = {
--                     alpha = "Alpha",
--                     fzf = "FZF",
--                     TelescopePrompt = "Telescope",
--                 }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
--                 padding = {},
--             },
--             { -- Breadcrumbs
--                 "navic",
--                 color_correction = nil,
--                 navic_opts = nil,
--             },
--             { -- If there is nothing after the navic module the backgound color doesn't work on it.
--                 -- I don't know why, and I frankly don't care.
--                 function()
--                     return "%="
--                 end,
--             },
--         },
--     },
-- }

return M
