return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ 
				"nvim-telescope/telescope-ui-select.nvim",
				config = function()
					require("telescope").load_extension("ui-select")
				end,
			},
		},
		opts = {
			defaults = {
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				file_ignore_patterns = { ".git/" }
			},
			pickers = {
				find_files = {
					hidden = true
				}
			}
		},
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find files with Telescope",
			}
		},
	},
}
