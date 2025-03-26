---@type LazyPluginSpec[]
return {
	{
		"garymjr/nvim-snippets",
		enabled = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		opts = {
			friendly_snippets = true,
		},
		keys = {
			{
				"<Tab>",
				function()
					if vim.snippet.active({ direction = 1 }) then
						vim.schedule(function()
							vim.snippet.jump(1)
						end)
						return
					end
					return "<Tab>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<Tab>",
				function()
					vim.schedule(function()
						vim.snippet.jump(1)
					end)
				end,
				expr = true,
				silent = true,
				mode = "s",
			},
			{
				"<S-Tab>",
				function()
					if vim.snippet.active({ direction = -1 }) then
						vim.schedule(function()
							vim.snippet.jump(-1)
						end)
						return
					end
					return "<S-Tab>"
				end,
				expr = true,
				silent = true,
				mode = { "i", "s" },
			},
		},
	},
	{
		"supermaven-inc/supermaven-nvim",
		enabled = false,
		opts = {
			disable_inline_completion = true, -- disables inline completion for use with cmp
			disable_keymaps = true, -- disables built in keymaps for more manual control
		},
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		dependencies = {
			"rafamadriz/friendly-snippets",
			"andersevenrud/cmp-tmux",
			{
				"saghen/blink.compat",
				verion = "*",
				lazy = true,
				otps = {},
			},
			"moyiz/blink-emoji.nvim",
			"MahanRahmati/blink-nerdfont.nvim",
		},
		event = "InsertEnter",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			appearance = {
				nerd_font_variant = "normal",
			},
			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				ghost_text = {
					enabled = true,
				},
				documentation = { auto_show = true },
				menu = {
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind" },
						},
						treesitter = { "lsp" },
					},
				},
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"lazydev",
					"tmux",
					"emoji",
					"nerdfont",
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100, -- show at a higher priority than lsp
					},
					tmux = {
						name = "tmux",
						module = "blink.compat.source",
						score_offset = -3,
						min_keyword_length = 3,
						-- opts = {
						-- 	all_panes = true,
						-- },
					},
					emoji = {
						name = "emoji",
						module = "blink-emoji",
						async = true
					},
					nerdfont = {
						name = "Nerd Fonts",
						module = "blink-nerdfont",
						async = true
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"hrsh7th/nvim-cmp",
		enabled = false,
		version = false,
		event = "InsertEnter",
		dependencies = {
			"andersevenrud/cmp-tmux",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"garymjr/nvim-snippets",
		},
		opts = function()
			local cmp = require("cmp")

			---@class cmp.ConfigSchema
			return {
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				---@class cmp.FormattingConfig
				formatting = {
					format = function(entry, vim_item)
						vim_item.kind = string.format("%s %s", Utils.kind_icons[vim_item.kind], vim_item.kind)
						vim_item.menu = ({
							buffer = "[buffer]",
							latex_symbols = "[LaTeX]",
							snippets = "[snippets]",
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
					{ name = "render-markdown" },
					{ name = "lazydev", group_index = 0 },
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
			}
		end,
	},
}
