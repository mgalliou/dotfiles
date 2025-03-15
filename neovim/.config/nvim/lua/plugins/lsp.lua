return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
		},
		build = ":MasonUpdate",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<CR>", desc = "Mason" } },
		config = true,
	},
	{
		"neovim/nvim-lspconfig",
		event = Utils.buf_events,
		dependencies = {
			{
				{
					"williamboman/mason-lspconfig.nvim",
					dependencies = {
						"mason.nvim",
					},
					config = true,
				},
			},
		},
		config = function()
			vim.diagnostic.config({
				virtual_text = { spacing = 4, prefix = "●" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = Utils.on_attach,
			})

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local capabilities = require("cmp_nvim_lsp").default_capabilities()

					require("lspconfig")[server_name].setup({
						settings = Utils.servers[server_name] or {},
						capabilities = capabilities,
					})
				end,
				["rust_analyzer"] = function() end,
				["ts_ls"] = function() end,
				["yamlls"] = function() end,
			})

			local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = "󰋽 " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			local kinds = vim.lsp.protocol.CompletionItemKind
			local kind_icons = Utils.kind_icons
			for i, kind in ipairs(kinds) do
				kinds[i] = kind_icons[kind] or kind
			end
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		lazy = false,
		config = function()
			vim.g.rustaceanvim = {
				server = {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				},
			}
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
	},
	{
		"pmizio/typescript-tools.nvim",
		event = Utils.buf_events,
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			settings = {
				complete_function_calls = true,
				expose_as_code_action = "all",
			},
		},
		ft = { "javascript", "typescript" },
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = Utils.buf_events,
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
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
					null_ls.builtins.diagnostics.checkmake,
					null_ls.builtins.formatting.prettierd.with({
						env = {
							PRETTIERD_DEFAULT_CONFIG = vim.fn.expand(
								"~/.config/nvim/utils/linter-config/.prettierrc.json"
							),
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
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "lazy.nvim", words = { "LazyVim" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "wezterm-types", mods = { "wezterm" } },
			},
		},
	},
	{
		"Bilal2453/luvit-meta",
		lazy = true,
	},
}
