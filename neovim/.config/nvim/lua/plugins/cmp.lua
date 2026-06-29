---@type LazyPluginSpec[]
return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"saghen/blink.compat",
				version = "*",
				lazy = true,
				opts = {},
			},
			"moyiz/blink-emoji.nvim",
			"MahanRahmati/blink-nerdfont.nvim",
			"mgalliou/blink-cmp-tmux",
		},
		event = "InsertEnter",
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
						score_offset = 100,
					},
					lsp = {
						score_offset = 50,
					},
					tmux = {
						name = "tmux",
						module = "blink-cmp-tmux",
						opts = {
							all_panes = true,
							capture_history = true,
						},
						score_offset = -15,
					},
					emoji = {
						name = "emoji",
						module = "blink-emoji",
						score_offset = -15,
					},
					nerdfont = {
						name = "Nerd Fonts",
						module = "blink-nerdfont",
						score_offset = -15,
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
			disable_inline_completion = true,
			disable_keymaps = true,
		},
	},
}
