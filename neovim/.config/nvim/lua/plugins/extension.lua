return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- TODO: configure
		opts = {
			use_diagnostic_signs = true,
		},
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "DiffviewOpen" },
		-- TODO: configure
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
		dependencies = {
			{ "MunifTanjim/nui.nvim", lazy = true },
		},
		opts = {
			-- NOTE: workaround to prevent flickering when changing source
			git_status_async = false,
			filesystem = {
				-- NOTE: workaround to prevent flickering when changing source
				async_directory_scan = "never",
				filtered_items = {
					hide_dotfiles = false,
					hide_hidden = false,
					hide_gitignored = false,
				},
			},
			source_selector = {
				winbar = true,
			},
			add_blank_line_at_top = true,
			close_if_last_window = true,
		},
		-- TODO: add keymaps
		keys = {
			{ "<A-1>", "<cmd>NeoTreeFocusToggle<cr>", desc = "Toggle Neo-tree" },
		},
	},
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startup_tries = 10
		end,
	},
}
