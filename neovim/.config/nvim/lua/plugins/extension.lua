return {
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
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
				"<cmd>Trouble symbols toggle<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cS",
				"<cmd>Trouble lsp toggle<cr>",
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
			{
				"[q",
				function()
					if require("trouble").is_open() then
						---@diagnostic disable-next-line: missing-parameter, missing-fields
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						---@diagnostic disable-next-line: missing-parameter, missing-fields
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
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
