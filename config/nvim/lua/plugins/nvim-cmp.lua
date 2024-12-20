return function()
	-- See `:help cmp`
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	luasnip.config.setup({})

	cmp.setup({
		-- snippet = {
		-- 	expand = function(args)
		-- 		luasnip.lsp_expand(args.body)
		-- 	end,
		-- },
		completion = { completeopt = "menu,menuone,noinsert" },

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
		sources = {
			{
				name = "lazydev",
				-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
				group_index = 0,
			},
			{ name = "git" },
			{ name = "calc" },
			{ name = "nvim_lsp" },
			{ name = "omni" },
			{ name = "luasnip" },
			{ name = "path" },
			{
				name = "latex_symbols",
				option = {
					strategy = 2, -- latex commnand
				},
			},
		},
	})
end
