return {
	{
		"garymjr/nvim-snippets",
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
		"hrsh7th/nvim-cmp",
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
			local kind_icons = Utils.kind_icons

			return {
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
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
