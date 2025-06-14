---@type LazyPluginSpec[]
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/neoconf.nvim",
				opts = {},
				cmd = "Neoconf",
			},
		},
		event = Utils.buf_events,
		---@class PluginLspOpts
		opts = {
			---@type vim.diagnostic.Opts
			diagnostics = {
				virtual_text = { spacing = 4, prefix = "●" },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			},
			---@type lspconfig.options
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
								workspaceWord = true,
							},
							format = {
								enable = false,
							},
							workspace = {
								checkThirdParty = true,
								library = {
									"/usr/share/awesome/lib",
								},
							},
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							customTags = { "!reference sequence" },
						},
						schemas = {
							["https://gitlab.com/gitlab-org/gitlab/-/blob/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
						},
					},
				},
				helm_ls = {
					settings = {
						["helm-ls"] = {
							yamlls = {
								enabled = true,
							},
						},
					},
				},
				ts_ls = {
					settings = {
						typescript = {
							format = {
								enable = false,
							},
						},
						javascript = {
							format = {
								enable = false,
							},
						},
					},
				},
				html = {
					init_options = {
						provideFormatter = false,
					},
				},
				cssls = {
					init_options = {
						provideFormatter = false,
					},
				},
				jsonls = {
					init_options = {
						provideFormatter = false,
					},
				},
			},
		},
		---@param opts PluginLspOpts
		config = function(_, opts)
			vim.diagnostic.config(opts.diagnostics)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = Utils.on_attach,
			})

			for server_name, server_opts in pairs(opts.servers) do
				vim.lsp.config(server_name, {
					settings = server_opts and server_opts.settings or {},
					capabilities = Utils.capabilities(),
					init_options = server_opts and server_opts.init_options or {},
				})
			end

			local kinds = vim.lsp.protocol.CompletionItemKind
			local kind_icons = Utils.kind_icons
			for i, kind in ipairs(kinds) do
				kinds[i] = kind_icons[kind] or kind
			end
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{
				"mason-org/mason.nvim",
				build = ":MasonUpdate",
				cmd = "Mason",
				opts = {},
				keys = { { "<leader>cm", "<cmd>Mason<CR>", desc = "Mason" } },
			},
			"nvim-lspconfig",
		},
		---@module "mason-lspconfig"
		---@type MasonLspconfigSettings
		opts = {
			ensure_installed = {
				"lua_ls",
			},
			automatic_enable = {
				exclude = {
					"rust_analyzer",
					"jdtls",
					"ts_ls",
					"yamlls",
				},
			},
		},
	},
	{
		"mrcjkb/rustaceanvim",
		ft = { "rust" },
	},
	{
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {
			completion = {
				crates = {
					enabled = true,
				},
			},
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		ft = { "javascript", "typescript" },
		opts = {
			on_attach = Utils.on_attach,
			settings = {
				complete_function_calls = true,
				expose_as_code_action = "all",
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		---@type lazydev.Config
		opts = {
			library = {
				{ path = "lazy.nvim" },
				{ path = "lazydev.nvim" },
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
	{
		"nvimtools/none-ls.nvim",
		event = Utils.buf_events,
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.yamllint.with({
						extra_args = { "-d", "{extends: relaxed}" },
					}),
					null_ls.builtins.diagnostics.markdownlint_cli2.with({
						args = { "**/*.md" },
					}),
					null_ls.builtins.diagnostics.fish,
					null_ls.builtins.formatting.prettier.with({
						extra_filetypes = { "gotmpl", "helm" },
					}),
					null_ls.builtins.formatting.fish_indent,
					null_ls.builtins.formatting.shellharden.with({
						extra_filetypes = { "tmux" },
					}),
				},
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"none-ls.nvim",
		},
		---@module "mason-null-ls"
		---@type MasonNullLsSettings
		opts = {
			ensure_installed = {
				"gitlint",
				"markdownlint_cli2",
			},
			handlers = {},
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
}
