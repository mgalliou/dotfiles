---@type LazyPluginSpec[]
return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		dependencies = {
			"rafamadriz/friendly-snippets",
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
		"supermaven-inc/supermaven-nvim",
		enabled = false,
		opts = {
			disable_inline_completion = true, -- disables inline completion for use with cmp
			disable_keymaps = true, -- disables built in keymaps for more manual control
		},
	},
}
