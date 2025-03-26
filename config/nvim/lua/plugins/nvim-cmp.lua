return function()
    -- See `:help cmp`
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    luasnip.config.setup({})

    -- cmp.setup({})
    local config = {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },

        preselect = cmp.PreselectMode.None,
        completion = {
            completeopt = "menu,menuone,noinsert",
            keyword_length = 2,
        },

        window = {
            completion = {
                -- winblend = 70,
                scrollbar = false,
                border = "rounded", -- see :h nvim_open_win
                -- winhighlight = "Normal:Pmenu,CursorLine:CmpCursorLine,Search:None",
                col_offset = -3,
                side_padding = 0,
            },
            documentation = cmp.config.window.bordered(),
        },

        experimental = {
            ghost_text = false, -- this feature conflict with copilot.vim's preview.
        },
        performance = {
            max_view_entries = 30, -- This limits the number of entries shown in the window. not quite what I want, but itsa start
        },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
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
            ["<Right>"] = cmp.mapping.confirm({ select = true }),
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

    local lspkind = require("lspkind")
    config.formatting = {}
    config.formatting.fields = { "abbr", "kind", "menu" }
    config.formatting.format = lspkind.cmp_format({
        mode = "symbol_text", -- show only symbol annotations
        preset = "codicons",
        maxwidth = {
            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as
            -- menu = function() return math.floor(0.45 * vim.o.columns) end,
            menu = 20, -- leading text (labelDetails)
            abbr = 20, -- actual suggestion item
        },
        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        show_labelDetails = true, -- show labelDetails in menu. Disabled by default

        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function(entry, item) -- type / symbol / source
            local source = entry.source.name
            if source == "nvim_lsp" then
                source = "LSP"
            end
            item.menu_hl_group = "Comment"

            -- if source == "buffer" then
            --     item.menu_hl_group = nil
            --     item.menu = nil
            -- else
            item.menu = "[" .. source .. "]"
            -- end

            local frac_win_width = math.floor(vim.api.nvim_win_get_width(0) * 0.3)
            if vim.api.nvim_strwidth(item.abbr) > frac_win_width then
                item.abbr = ("%s…"):format(item.abbr:sub(1, frac_win_width))
            end

            if item.menu then -- Add exta space to visually differentiate `abbr` and `menu`
                item.abbr = ("%s "):format(item.abbr)
            end

            return item
            -- ...
        end,
    })

    config.sources = { -- global sources
        { name = "nvim_lsp" }, -- TODO: how to limit recommendation page hight
        {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
        },
        { name = "luasnip", group_index = 1 },
        { name = "omni" },
        { name = "path" }, -- file system path
        { name = "git" },
    }

    cmp.setup(config)

    cmp.setup.filetype({ "tex", "bib" }, { -- filetype sources. overrides global
        sources = cmp.config.sources({
            { name = "nvim_lsp", group_index = 2, max_item_count = 7 },
            { name = "vimtex", group_index = 1, max_item_count = 8 },
            { name = "luasnip", group_index = 0 },
            { name = "omni" },
            { name = "git" },
            -- { name = "latex_symbols", max_item_count = 8, group_index = 2, option = { strategy = 2 } },
            { name = "path" }, -- file system path
        }),
    })

    cmp.setup.filetype({ "go" }, { --TODO: FINISH THIS.
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "go_pkgs" },
            { name = "luasnip", group_index = 1 },
            { name = "git" },
            { name = "omni" },
            { name = "path" }, -- file system path
        }),
    })

    -- commandline completions
    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            {
                name = "cmdline",
                option = {
                    ignore_cmds = { "Man", "!" },
                },
            },
        }),
    })
end
