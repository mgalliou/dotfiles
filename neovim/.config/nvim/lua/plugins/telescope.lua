---@type LazyPluginSpec[]
return {
	{
		"nvim-telescope/telescope.nvim",
		enabled = false,
		version = false,
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
		},
		cmd = "Telescope",
		opts = function()
			return {
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
			}
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("ui-select")
		end,
		keys = function()
			local t = require("telescope.builtin")
			-- stylua: ignore
			return {
				{ "<leader>/", function() t.live_grep() end, desc = "grep (Root Dir)" },
				{ "<leader>:", function() t.command_history() end, desc = "Command History" },
				{ "<leader><space>", function() t.find_files({ no_ignore = true, no_ignore_parent = true }) end, desc = "Find files (Root Dir))" },
				{ "<leader>ff", function() t.find_files({ no_ignore = true, no_ignore_parent = true }) end, desc = "Find files (Root Dir))" },
				{ "<leader>fF", function() t.find_files({ cwd = require("telescope.utils").buffer_dir(), no_ignore = true, no_ignore_parent = true }) end, desc = "Find files (Buffer Dir)" },
				{ "<leader>fg", function() t.git_files() end, desc = "Find git files (Root Dir)" },
				{ "<leader>fG", function() t.git_files({ cwd = require("telescope.utils").buffer_dir() }) end, desc = "Find git files (Buffer Dir)" },
				{ "<leader>fr", function() t.oldfiles() end, desc = "Find recent files" },
				{ "<leader>fb", function() t.buffers() end, desc = "Find buffers" },
				{ '<leader>s"', function() t.registers() end, desc = "Registers" },
				{ "<leader>sm", function() t.marks() end, desc = "Registers" },
				{ "<leader>sh", function() t.help_tags() end, desc = "Search helptags" },
				{ "<leader>so", function() t.vim_options() end, desc = "Search Options" },
				{ "<leader>sm", function() t.man_pages() end, desc = "Search man pages" },
				{ "<leader>ss", function() t.lsp_document_symbols({ symbols = Utils.symbol_types, }) end, desc = "Search Symbols" },
				{ "<leader>sS", function() t.lsp_dynamic_workspace_symbols({ symbols = Utils.symbol_types, }) end, desc = "Search Symbols (Workspace)" },
				{ "<leader>sR", function() t.resume() end, desc = "Resume last picker" },
			}
		end,
	},
	{
		"johmsalas/text-case.nvim",
		enabled = false,
		dependencies = { "nvim-telescope/telescope.nvim" },
		cmd = {
			"Subs",
			"TextCaseOpenTelescope",
			"TextCaseOpenTelescopeQuickChange",
			"TextCaseOpenTelescopeLSPChange",
			"TextCaseStartReplacingCommand",
		},
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
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		enabled = false,
		lazy = true,
	},
}
