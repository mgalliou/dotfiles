return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"hrsh7th/cmp-nvim-lsp",
				{ "folke/neodev.nvim", config = true },
				"simrat39/rust-tools.nvim",
				"mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				{
					"filipdutescu/renamer.nvim",
					enabled = false,
					dependencies = {
						"nvim-lua/plenary.nvim",
					},
					opts = {
						border_chars = require("tools").borderchars,
					},
					keys = {
						{
							"<F2>",
							function()
								require("renamer").rename({})
							end,
							mode = "i",
							desc = "Rename with lsp",
						},
						{
							"<leader>r",
							function()
								require("renamer").rename({})
							end,
							mode = { "n", "v" },
							desc = "Rename with lsp",
						},
					},
				},
				{
					"kosayoda/nvim-lightbulb",
					enabled = false,
					opts = {
						sign = {
							enabled = false,
						},
						virtual_text = {
							enabled = true,
							hl_mode = "combine",
						},
						status_text = {
							enabled = true,
						},
						autocmd = {
							enabled = true,
							events = { "CursorHold", "CursorHoldI" },
						},
					},
				},
			},
		},
		config = function()
			local diag = vim.diagnostic
			local opts = { noremap = true, silent = true }

			diag.config({
				virtual_text = { spacing = 4, prefix = "●" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			local km = require("tools").set_keymap_opts
			km("n", "<leader>e", diag.open_float, opts, "Diagnostic float")
			km("n", "[d", diag.goto_prev, opts, "Previous Diagnostic")
			km("n", "]d", diag.goto_next, opts, "Next Diagnostic")
			km("n", "<leader>sll", diag.setloclist, opts, "Diagnostics in quickfix")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = require("tools").on_attach,
			})

			--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local capabilities = require("cmp_nvim_lsp").default_capabilities()
					require("lspconfig")[server_name].setup({
						settings = require("tools").servers[server_name] or {},
						capabilities = capabilities,
					})
				end,
				["rust_analyzer"] = function()
					local capabilities = require("cmp_nvim_lsp").default_capabilities()
					require("rust-tools").setup({
						server = {
							capabilities = capabilities,
						},
					})
				end,
				["tsserver"] = function() end,
			})
			local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = "󰋽 " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			local kinds = vim.lsp.protocol.CompletionItemKind
			local kind_icons = require("tools").kind_icons
			for i, kind in ipairs(kinds) do
				kinds[i] = kind_icons[kind] or kind
			end
		end,
	},
	{ "mfussenegger/nvim-jdtls" },
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = "mason.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.code_actions.shellcheck,
					null_ls.builtins.diagnostics.yamllint.with({
						extra_args = { "-d", "{extends: relaxed}" },
					}),
					null_ls.builtins.diagnostics.markdownlint.with({
						extra_args = {
							"--config",
							vim.fn.expand("~/.config/nvim/utils/linter-config/.markdownlint.yaml"),
						},
					}),
					null_ls.builtins.diagnostics.fish,
					null_ls.builtins.diagnostics.gitlint,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.diagnostics.flake8,
					null_ls.builtins.formatting.prettierd.with({
						env = {
							PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/linter-config/.prettierrc"),
						},
						extra_filetypes = { "gotmpl", "helm" },
					}),
					null_ls.builtins.formatting.fish_indent,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.shellharden.with({
						extra_filetypes = { "tmux" },
					}),
					null_ls.builtins.formatting.stylua,
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
		},
		keys = { { "<leader>cm", "<cmd>Mason<CR>", desc = "Open Mason" } },
		opts = {
			ensure_installed = {
				"bash-language-server",
				"gitlint",
				"helm-ls",
				"jdtls",
				"jq",
				"jq",
				"lua-language-server",
				"markdownlint",
				"marksman",
				"prettierd",
				"shellcheck",
				"shellharden",
				"stylua",
				"taplo",
				"vim-language-server",
				"yaml-language-server",
				"yamllint",
			},
		},
	},
}
