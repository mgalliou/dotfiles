local function T(s, o)
	return function()
		require("telescope.builtin")[s](o)
	end
end

return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-ui-select.nvim",
				config = function()
					require("telescope").load_extension("ui-select")
				end,
			},
			{
				"johmsalas/text-case.nvim",
				config = function()
					require("telescope").load_extension("textcase")
					vim.keymap.set({ "n", "v" }, "<leader>~", "<CMD>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
				end,
			},
		},
		opts = {
			defaults = {
				file_ignore_patterns = { ".git/" },
				borderchars = require("tools").borderchars,
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
					no_ignore = true,
				},
			},
		},
		-- TODO: change and add more keybind
		keys = {
			{ "<leader>f", T("find_files"), desc = "Find files with Telescope" },
			{
				"<leader>F",
				T("find_files", { cwd = false }),
				desc = "Find files in current working directory Telescope",
			},
			--{ "<leader>fd", T("find_files", { cwd = "~/dotfiles" }), desc = "Find dotfiles with Telescope" },
			{ "<leader>/", T("live_grep"), desc = "Grep in currend directory with Telescope" },
			{ "<leader>b", T("buffers"), desc = "Find buffer with Telescope" },
			{ "<leader>H", T("help_tags"), desc = "Find helptags with Telescope" },
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
				desc = "Goto Symbol",
			},
		},
	},
}
