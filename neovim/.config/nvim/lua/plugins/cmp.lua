return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		build = "make install_jsregexp",
		keys = {
			{
				"<tab>",
				function()
					return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<tab>",
				function()
					return require("luasnip").jumpable(1)
				end,
				mode = "s",
			},
			{
				"<s-tab>",
				function()
					return require("luasnip").jumpable(-1)
				end,
				mode = { "i", "s" },
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"andersevenrud/cmp-tmux",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-emoji",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local kind_icons = require("tools").kind_icons

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				formatting = {
					format = function(entry, vim_item)
						vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
						vim_item.menu = ({
							buffer = "[buffer]",
							latex_symbols = "[LaTeX]",
							luasnip = "[LuaSnip]",
							nvim_lsp = "[LSP]",
							nvim_lua = "[nvim_lua]",
							tmux = "[tmux]",
						})[entry.source.name]
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
					["<Tab>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "lazydev", group_index = 0 },
					{ name = "luasnip", option = { show_autosnippets = true } },
					{ name = "path" },
					{ name = "emoji" },
					{
						name = "tmux",
						option = {
							all_panes = true,
						},
					},
					{
						name = "buffer",
						option = {
							keyword_length = 1,
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end,
						},
					},
				}),
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
			})
		end,
	},
}
