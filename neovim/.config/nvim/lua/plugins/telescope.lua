---@type LazyPluginSpec[]
return {
	{
		"nvim-telescope/telescope.nvim",
		version = false,
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		opts = {
			defaults = {
				file_ignore_patterns = { ".git/" },
				borderchars = Utils.borderchars.default,
				wrap_results = true,
				prompt_prefix = " ",
				selection_caret = " ",
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"-.",
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_cursor({
						borderchars = {
							prompt = Utils.borderchars.bottom_linked,
							results = Utils.borderchars.top_linked,
							preview = Utils.borderchars.defaults,
						},
					}),
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("ui-select")
		end,
		keys = function()
			-- stylua: ignore
			return {
				{ "<leader>/", function() require("telescope.builtin").live_grep() end, desc = "grep (Root Dir)" },
				{ "<leader>:", function() require("telescope.builtin").command_history() end, desc = "Command History" },
				{ "<leader><space>", function() require("telescope.builtin").find_files({ no_ignore = true, no_ignore_parent = true }) end, desc = "Find files (Root Dir))" },
				{ "<leader>ff", function() require("telescope.builtin").find_files({ no_ignore = true, no_ignore_parent = true }) end, desc = "Find files (Root Dir))" },
				{ "<leader>fF", function() require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir(), no_ignore = true, no_ignore_parent = true }) end, desc = "Find files (Buffer Dir)" },
				{ "<leader>fg", function() require("telescope.builtin").git_files() end, desc = "Find git files (Root Dir)" },
				{ "<leader>fG", function() require("telescope.builtin").git_files({ cwd = require("telescope.utils").buffer_dir() }) end, desc = "Find git files (Buffer Dir)" },
				{ "<leader>fr", function() require("telescope.builtin").oldfiles() end, desc = "Find recent files" },
				{ "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Find buffers" },
				{ '<leader>s"', function() require("telescope.builtin").registers() end, desc = "Registers" },
				{ "<leader>sm", function() require("telescope.builtin").marks() end, desc = "Registers" },
				{ "<leader>sh", function() require("telescope.builtin").help_tags() end, desc = "Search helptags" },
				{ "<leader>so", function() require("telescope.builtin").vim_options() end, desc = "Search Options" },
				{ "<leader>sm", function() require("telescope.builtin").man_pages() end, desc = "Search man pages" },
				{ "<leader>ss", function() require("telescope.builtin").lsp_document_symbols({ symbols = Utils.symbol_types, }) end, desc = "Search Symbols" },
				{ "<leader>sS", function() require("telescope.builtin").lsp_dynamic_workspace_symbols({ symbols = Utils.symbol_types, }) end, desc = "Search Symbols (Workspace)" },
				{ "<leader>sR", function() require("telescope.builtin").resume() end, desc = "Resume last picker" },
			}
		end,
	},
	{
		"johmsalas/text-case.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {
			default_keymappings_enabled = false,
		},
		config = function(_, opts)
			require("textcase").setup(opts)
			require("telescope").load_extension("textcase")
		end,
		keys = {
			{ "<leader>~", "<CMD>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Text case (Telescope)" },
		},
		cmd = {
			"Subs",
			"TextCaseOpenTelescope",
			"TextCaseOpenTelescopeQuickChange",
			"TextCaseOpenTelescopeLSPChange",
			"TextCaseStartReplacingCommand",
		},
	},
}
