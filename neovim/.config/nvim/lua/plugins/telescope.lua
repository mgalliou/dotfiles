local function T(s, o)
	return function()
		require("telescope.builtin")[s](o)
	end
end

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
		keys = {
			{ "<leader>f", T("find_files"), desc = "Find git files (Telescope)" },
			{
				"<leader>F",
				T("find_files", { no_ignore = true }),
				desc = "Find files (Telescope)",
			},
			{ "<leader>/", T("live_grep"), desc = "Grep (Telescope)" },
			{ "<leader>b", T("buffers"), desc = "Find buffers (Telescope)" },
			{ "<leader>H", T("help_tags"), desc = "Find helptags (Telescope)" },
			{
				"<leader>s",
				T("lsp_document_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "List Lsp Symbols (Telescope)",
			},
		},
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
	{
		"FabianWirth/search.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{
				"<leader><leader>",
				function()
					require("search").open()
				end,
				desc = "Open finder",
			},
		},
	},
}
