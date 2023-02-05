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
		-- TODO: change and add more keybind
		keys = {
			{
				"<leader>ff",
				function() require("telescope.builtin").find_files() end,
				desc = "Find files with Telescope",
			},
			{
				"<leader>fd",
				function() require("telescope.builtin").find_files({ cwd = "~/dotfiles" }) end,
				desc = "Find dotfiles with Telescope",
			},
			{
				"<leader>fg",
				function() require("telescope.builtin").live_grep() end,
				desc = "Grep in currend directory with Telescope",
			},
			{
				"<leader>fb",
				function() require("telescope.builtin").buffers() end,
				desc = "Find buffer with Telescope",
			},
			{
				"<leader>fh",
				function() require("telescope.builtin").help_tags() end,
				desc = "Find helptags with Telescope",
			},
		},
	},
}
