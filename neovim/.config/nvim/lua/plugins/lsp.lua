local function config_custom_server(name, cmd, filetypes, root_pattern)
	local configs = require("lspconfig.configs")
	if not configs[name] then
		configs[name] = {
			default_config = {
				cmd = cmd,
				filetypes = filetypes,
				root_dir = function(fname)
					return require("lspconfig.util").root_pattern(root_pattern)(fname)
				end,
			},
		}
	end
end

return {
	{
		'neovim/nvim-lspconfig',
		event = "BufReadPre",
		dependencies = {
			{
				{ "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
				'simrat39/rust-tools.nvim',
				'mason.nvim',
				'williamboman/mason-lspconfig.nvim',
				{
					'filipdutescu/renamer.nvim',
					opts = {
						border_chars = require("tools").borderchars,
					},
					keys = {
						{ "<F2>", function() require("renamer").rename({}) end, mode = 'i', desc = "Rename with lsp" },
						{ "<leader>rn", function() require("renamer").rename({}) end, mode = { 'n', 'v' }, desc = "Rename with lsp" }
					},
				},
				{
					'kosayoda/nvim-lightbulb',
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
							events = { "CursorHold", "CursorHoldI" }
						}
					}
				},
			},
		},
		config = function()
			local diag = vim.diagnostic
			local opts = { noremap = true, silent = true }

			diag.config {
				virtual_text = { spacing = 4, prefix = "●" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			}
			vim.keymap.set('n', "<leader>e", diag.open_float, opts)
			vim.keymap.set('n', "[d", diag.goto_prev, opts)
			vim.keymap.set('n', "]d", diag.goto_next, opts)
			vim.keymap.set('n', "<leader>sll", diag.setloclist, opts)

			local lspconfig = require("lspconfig")
			local on_attach = require("tools").on_attach
			local lsp_flags = {
				-- This is the default in Nvim 0.7+
				debounce_text_changes = 150,
			}

			local configs = require("lspconfig.configs")
			if not configs.helm_ls then
				configs.helm_ls = {
					default_config = {
						cmd = { "helm_ls", "serve" },
						filetypes = { "helm" },
						root_dir = function(fname)
							return require("lspconfig.util").root_pattern("Chart.yaml")(fname)
						end,
					},
				}
			end

			local servers = {
				lua_ls = {
					Lua = {
						completion = {
							callSnippet = "Replace"
						},
						workspace = {
							library = {
								"/usr/share/awesome/lib",
							},
						},
					},
				},
				bashls = {},
				vimls = {},
				ccls = {},
				lemminx = {},
				marksman = {},
				dockerls = {},
				ansiblels = {},
				solargraph = {},
				terraformls = {},
				yamlls = {
					yaml = {
						keyOrdering = false
					}
				},
				helm_ls = {
					filetypes = { "helm" },
					cmd = { "helm_ls", "serve" },
				},
				angularls = {},
				kotlin_language_server = {}
			}

			for ls, opt in pairs(servers) do
				lspconfig[ls].setup({
					on_attach = on_attach,
					flags = lsp_flags,
					settings = opt
				})
			end

			require("rust-tools").setup {
				server = {
					on_attach = on_attach,
				},
			}

			--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			local kinds = vim.lsp.protocol.CompletionItemKind
			local kind_icons = require("tools").kind_icons
			for i, kind in ipairs(kinds) do
				kinds[i] = kind_icons[kind] or kind
			end
		end
	},
	{ 'mfussenegger/nvim-jdtls' },
	{
		'jose-elias-alvarez/null-ls.nvim',
		event = "BufReadPre",
		dependencies = "mason.nvim",
		-- TODO: config
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.code_actions.shellcheck,
					null_ls.builtins.formatting.beautysh,
					null_ls.builtins.formatting.shellharden,
					null_ls.builtins.formatting.jq
				},

				on_attach = require("tools").on_attach,
			})
		end
	},
	{
		'williamboman/mason.nvim',
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<CR>", desc = "Open Mason" } },
		-- TODO: configure `ensure_installed`
		config = true
	},
}
