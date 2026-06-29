---@type LazyPluginSpec[]
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/neoconf.nvim",
				cmd = "Neoconf",
				opts = {},
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
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							format = {
								enable = false,
							},
							hint = {
								arrayIndex = "Disable",
							},
							runtime = {
								version = "LuaJIT",
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
			"nvim-lspconfig",
			{
				"mason-org/mason.nvim",
				build = ":MasonUpdate",
				cmd = "Mason",
				keys = { { "<leader>cm", "<cmd>Mason<CR>", desc = "Mason" } },
				opts = {},
			},
		},
		---@type function|MasonLspconfigSettings
		opts = function()
			local ensure = {}
			if Utils.is_termux() then
				vim.lsp.enable("lua_ls")
			else
				ensure = { "lua_ls" }
			end
			return {
				ensure_installed = ensure,
				automatic_enable = {
					exclude = {
						"rust_analyzer",
						"jdtls",
						"ts_ls",
						"yamlls",
					},
				},
			}
		end,
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
		dependencies = {
			{
				"DrKJeff16/wezterm-types",
				lazy = true,
				version = false,
			},
			{
				"Bilal2453/luvit-meta",
				lazy = true,
			},
		},
		cmd = "LazyDev",
		---@type lazydev.Config
		opts = {
			library = {
				{ "lazydev.nvim" },
				{ "blink.cmp" },
				{ "gruvbox.nvim" },
				{ "mason-lspconfig.nvim" },
				{ "mason-null-ls.nvim" },
				{ "render-markdown.nvim" },
				{ path = "lazy.nvim" },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "wezterm-types", mods = { "wezterm" } },
				{ path = "/usr/share/awesome/lib/", mods = { "awesome" } },
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
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
					null_ls.builtins.diagnostics.gdlint,
					null_ls.builtins.formatting.prettier.with({
						extra_filetypes = { "gotmpl", "helm" },
					}),
					null_ls.builtins.formatting.fish_indent,
					null_ls.builtins.formatting.gdformat,
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
		---@class MasonNullLsSettings
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
