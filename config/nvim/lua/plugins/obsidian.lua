---@type (fun(title: string|?, path: obsidian.Path|?): string)
local note_id = function(title)
    -- clean title
    title = vim.fn.substitute(title, "[^[:keyword:][:space:]-]", "", "g")
    title = vim.fn.substitute(title, "[_[:space:]]\\+", "-", "g")
    title = vim.fn.substitute(title, "-\\+", "-", "g")
    title = vim.fn.substitute(title, "^-\\+", "", "")
    title = vim.fn.substitute(title, "-\\+$", "", "")

    local suffix = ""
    for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
    end
    return tostring(os.date("%Y-%m-%d")) .. "-" .. title .. "-" .. suffix
end

return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- use latest release, remove to use latest commit
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        legacy_commands = false, -- this will be removed in the next major release
        workspaces = {
            {
                name = "personal",
                path = "~/Documents/vaults/personal",
            },
        },
        daily_notes = {
            enabled = true,
            folder = "daily_notes",
        },
        note_id_func = note_id,
    },
}
