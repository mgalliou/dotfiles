return {
	{
		'L3MON4D3/LuaSnip',
		dependencies = {
			'rafamadriz/friendly-snippets',
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end
		},
		keys = {
			{
				"<tab>",
				function()
					return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
				end,
				expr = true, silent = true, mode = 'i',
			},
			{
				"<tab>",
				function()
					return require("luasnip").jumpable(1)
				end,
				mode = 's',
			},
			{
				"<s-tab>",
				function()
					return require("luasnip").jumpable(-1)
				end,
				mode = {'i', 's'},
			}


		},
	},
	{
		'hrsh7th/nvim-cmp',
		version = false,
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-nvim-lsp',
			'saadparwaiz1/cmp_luasnip',
		},
		opts = function()
			local cmp = require("cmp")
			local kind_icons = require("tools").kind_icons
			cmp.setup {
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				formatting = {
					format = function(entry, vim_item)
						vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
						vim_item.menu = ({
							buffer = "[buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							nvim_lua = "[nvim_lua]",
							latex_symbols = "[LaTeX]",
						})[entry.source.name]
						return vim_item
					end
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					-- NOTE: seams useless to me
					-- ['<C-e>'] = cmp.mapping.abort(),
					['<C-e'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip", option = { show_autosnippets = true } },
					{ name = "buffer", keyword_length = 3 },
					{ name = "path" },
					{ name = "neorg" },
				}),
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
			}
		end
	},
}
