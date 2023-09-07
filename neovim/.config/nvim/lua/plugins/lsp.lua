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
				'hrsh7th/cmp-nvim-lsp',
				{ "folke/neodev.nvim", config = true },
				'simrat39/rust-tools.nvim',
				'mason.nvim',
				'williamboman/mason-lspconfig.nvim',
				{
					'filipdutescu/renamer.nvim',
					dependencies = {
						"nvim-lua/plenary.nvim"
					},
					opts = {
						border_chars = require("tools").borderchars,
					},
					keys = {
						{ "<F2>", function() require("renamer").rename({}) end, mode = 'i', desc = "Rename with lsp" },
						{ "<leader>r", function() require("renamer").rename({}) end, mode = { 'n', 'v' }, desc = "Rename with lsp" }
					},
				},
				{
					'kosayoda/nvim-lightbulb',
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
							events = { "CursorHold", "CursorHoldI" }
						}
					}
				},
			},
		},
		config = function()
			local diag = vim.diagnostic
			local opts = { noremap = true, silent = true }
			local lspconfig = require("lspconfig")
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local servers = {
				lua_ls = {
					Lua = {
						completion = {
							callSnippet = "Both",
              workspaceWord = true
						},
            format = {
              enable = false
            },
						workspace = {
              checkThirdParty = true,
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
				taplo = {},
				terraformls = {},
				jsonls = {},
				yamlls = {
					yaml = {
						customTags = { "!reference sequence" },
					},
					schemas = {
						["https://gitlab.com/gitlab-org/gitlab/-/blob/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml"
					}
				},
				--helm_ls = {},
				angularls = {},
				kotlin_language_server = {}
			}

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

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = require("tools").on_attach
			})

			for ls, opt in pairs(servers) do
				lspconfig[ls].setup({
					capabilities = capabilities,
					settings = opt
				})
			end

			require("rust-tools").setup {
				server = {
					capabilities = capabilities,
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
					null_ls.builtins.diagnostics.yamllint.with({
						filetypes = { "yaml", "helm" },
            -- TODO: check if `new-lines: false` is still needed
						extra_args = { "-d", "{extends: relaxed, rules: {new-lines: false}}" },
					}),
					null_ls.builtins.diagnostics.markdownlint.with({
						extra_args = { "--disable", "MD041" }
					}),
					null_ls.builtins.diagnostics.fish,
					null_ls.builtins.diagnostics.gitlint,
					null_ls.builtins.code_actions.shellcheck,
					null_ls.builtins.formatting.beautysh,
					null_ls.builtins.formatting.shellharden,
					null_ls.builtins.formatting.jq,
					null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.fish_indent,
          null_ls.builtins.formatting.shellharden,
          null_ls.builtins.formatting.stylua
				},
			})
		end
	},
	{
		'williamboman/mason.nvim',
		cmd = "Mason",
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
		},
		keys = { { "<leader>cm", "<cmd>Mason<CR>", desc = "Open Mason" } },
		-- TODO: configure `ensure_installed`
		config = true
	},
}
