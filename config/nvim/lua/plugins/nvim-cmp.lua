return function()
    -- See `:help cmp`
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    luasnip.config.setup({})

    -- cmp.setup({})
    -- snippet = {
    -- 	expand = function(args)
    -- 		luasnip.lsp_expand(args.body)
    -- 	end,
    -- },
    local config = {
        preselect = cmp.PreselectMode.None,
        completion = {
            completeopt = "menu,menuone,noinsert",
            keyword_length = 0,
            max_item_count = 20,
        },

        window = {
            completion = {
                -- winblend = 70,
                scrollbar = false,
                border = "rounded", -- { "╔", "═", "╗", "║", "╝", "═", "╚", "║" }, -- see :h nvim_open_win
                -- winhighlight = "Normal:Pmenu,CursorLine:CmpCursorLine,Search:None",
                col_offset = -3,
                side_padding = 0,
            },
            documentation = cmp.config.window.bordered(),
        },

        experimental = {
            ghost_text = false, -- this feature conflict with copilot.vim's preview.
        },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert({
            -- Select the [n]ext item
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<Tab>"] = cmp.mapping.select_next_item(),
            -- Select the [p]revious item
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            ["<C-S-n>"] = cmp.mapping.select_prev_item(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            -- Scroll the documentation window [b]ack / [f]orward
            -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete({}),

            -- Think of <c-l> as moving to the right of your snippet expansion.
            --  So if you have a snippet that's like:
            --  function $name($args)
            --    $body
            --  end
            --
            -- <c-l> will move you to the right of each of the expansion locations.
            -- <c-h> is similar, except moving you backwards.
            ["<C-l>"] = cmp.mapping(function()
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, { "i", "s" }),
            ["<C-h>"] = cmp.mapping(function()
                if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { "i", "s" }),

            -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
            --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        }),
    }

    config.sources = {
        {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
        },
        { name = "git" },
        { name = "nvim_lsp" },
        { name = "omni" },
        { name = "luasnip" },
        { name = "path" }, -- file system path
    }

    -- config.formatting = {
    --     fields = { "kind", "abbr", "menu" },
    --     format = function(entry, item)
    --         item.menu = entry.source.name
    --         return item
    --     end,
    -- }
    local formatting = {}
    formatting.fields = { "kind", "abbr", "menu" }
    formatting.format = function(entry, item)
        local kind = item.kind

        local source = entry.source.name
        if source == "nvim_lsp" or source == "path" then
        else
            item.menu_hl_group = "Comment"
        end
        item.menu = kind

        if source == "buffer" then
            item.menu_hl_group = nil
            item.menu = nil
        end

        local half_win_width = math.floor(vim.api.nvim_win_get_width(0) * 0.5)
        if vim.api.nvim_strwidth(item.abbr) > half_win_width then
            item.abbr = ("%s…"):format(item.abbr:sub(1, half_win_width))
        end

        if item.menu then -- Add exta space to visually differentiate `abbr` and `menu`
            item.abbr = ("%s "):format(item.abbr)
        end

        return item
    end
    config.formatting = formatting

    cmp.setup(config)

    cmp.setup.filetype({ "tex", "bib" }, { --TODO: FINISH THIS.
        sources = cmp.config.sources({
            { name = "git" },
            { name = "nvim_lsp", group_index = 2, max_item_count = 7 },
            { name = "omni" },
            -- { name = "latex_symbols", max_item_count = 8, group_index = 2, option = { strategy = 2 } },
            { name = "vimtex", group_index = 1, max_item_count = 8 },
            { name = "path" }, -- file system path
        }),
    })

    cmp.setup.filetype({ "go" }, { --TODO: FINISH THIS.
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "go_pkgs" },
            { name = "git" },
            { name = "omni" },
            { name = "path" }, -- file system path
        }),
    })
end
