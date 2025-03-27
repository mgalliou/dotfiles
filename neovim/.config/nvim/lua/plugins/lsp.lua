---@type LazyPluginSpec[]
return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<CR>", desc = "Mason" } },
		config = true,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/neoconf.nvim",
				cmd = "Neoconf",
				opts = {},
			},
			{
				"williamboman/mason-lspconfig.nvim",
				dependencies = {
					"mason.nvim",
				},
				config = true,
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
					disable_auto_setup = true,
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
				rust_analyzer = {
					disable_auto_setup = true,
				},
				jdtls = {
					disable_auto_setup = true,
				},
				ts_ls = {
					disable_auto_setup = true,
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
					settings = {
						html = {
							format = {
								enable = false,
							},
						},
					},
				},
				cssls = {
					settings = {
						css = {
							format = {
								enable = false,
							},
						},
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

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local server_opts = opts.servers[server_name]
					if not server_opts or server_opts and not server_opts.disable_auto_setup then
						require("lspconfig")[server_name].setup({
							settings = server_opts and server_opts.settings or {},
							capabilities = Utils.capabilities(),
						})
					end
				end,
			})

			local kinds = vim.lsp.protocol.CompletionItemKind
			local kind_icons = Utils.kind_icons
			for i, kind in ipairs(kinds) do
				kinds[i] = kind_icons[kind] or kind
			end
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				server = {
					capabilities = Utils.capabilities(),
				},
			}
		end,
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
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
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
		dependencies = { "nvim-lua/plenary.nvim" },
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
}
