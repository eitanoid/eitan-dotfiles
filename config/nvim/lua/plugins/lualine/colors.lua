local colors = { -- tokyonight moon theme (easier to just paste it here)
    bg = "#222436",
    bg_dark = "#1e2030",
    bg_dark1 = "#191B29",
    bg_highlight = "#2f334d",
    blue = "#82aaff",
    blue0 = "#3e68d7",
    blue1 = "#65bcff",
    blue2 = "#0db9d7",
    blue5 = "#89ddff",
    blue6 = "#b4f9f8",
    blue7 = "#394b70",
    comment = "#636da6",
    cyan = "#86e1fc",
    dark3 = "#545c7e",
    dark5 = "#737aa2",
    fg = "#c8d3f5",
    fg_dark = "#828bb8",
    fg_gutter = "#3b4261",
    green = "#c3e88d",
    green1 = "#4fd6be",
    green2 = "#41a6b5",
    magenta = "#c099ff",
    magenta2 = "#ff007c",
    orange = "#ff966c",
    purple = "#fca7ea",
    red = "#ff757f",
    red1 = "#c53b53",
    teal = "#4fd6be",
    terminal_black = "#444a73",
    yellow = "#ffc777",
    git = {
        add = "#b8db87",
        change = "#7ca1f2",
        delete = "#e26a75",
    },
}
--stylua: ignore
local mode_colors = {        -- color for each mode
    n = colors.blue,         -- normal
    no = colors.red,         -- normal operation pending
    i = colors.green,        -- insert
    v = colors.magenta,      -- visual
    [""] = colors.magenta, -- visual block
    V = colors.magenta,      -- visual line
    c = colors.yellow,       -- command mode
    s = colors.magenta,      -- select mode
    S = colors.magenta,      -- select line mode 
    [""] = colors.magenta, -- select block mode 
    ic = colors.yellow,      -- insert completion (?)
    R = colors.red,          -- replace mode
    Rv = colors.red,         -- virtual replace mode (?)
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    t = colors.teal,        -- terminal
    ["r?"] = colors.cyan,
    ["!"] = colors.red,
}

local theme = {
    normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
        b = { bg = colors.fg_gutter, fg = colors.blue },
        c = { bg = colors.bg_dark, fg = colors.fg_dark },
    },
    insert = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = colors.fg_gutter, fg = colors.green },
        c = { bg = colors.bg_dark, fg = colors.fg_dark },
    },
    visual = {
        a = { bg = colors.magenta, fg = colors.bg, gui = "bold" },
        b = { bg = colors.fg_gutter, fg = colors.magenta },
        c = { bg = colors.bg_dark, fg = colors.fg_dark },
    },
    replace = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = colors.fg_gutter, fg = colors.red },
        c = { bg = colors.bg_dark, fg = colors.fg_dark },
    },
    command = {
        a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
        b = { bg = colors.fg_gutter, fg = colors.orange },
        c = { bg = colors.bg_dark, fg = colors.fg_dark },
    },
    inactive = {
        a = { bg = colors.lightgray, fg = colors.inactivegray },
        b = { bg = colors.lightgray, fg = colors.inactivegray },
        c = { bg = colors.lightgray, fg = colors.inactivegray },
    },
}

return {
    colors = colors,
    mode_colors = mode_colors,
    theme = theme,
}
