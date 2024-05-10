return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- TODO: configure
		opts = {
			use_diagnostic_signs = true,
		},
		keys = {
			{ "<leader>d", ":TroubleToggle document_diagnostics<CR>", desc = "Trouble" },
			{ "<leader>D", ":TroubleToggle workspace_diagnostics<CR>", desc = "Trouble (workspace)" },
			{ "<leader>x", ":TodoTrouble<CR>", desc = "TodoTrouble" },
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
