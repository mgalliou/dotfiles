return {
	{
		"folke/neodev.nvim",
		-- TODO: config
		config = true,
	},
	{
		'williamboman/mason.nvim',
		config = true,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		config = true,
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{
				'simrat39/rust-tools.nvim',
			},
		},
		-- TODO: Refactor
		config = function()
			local diag = vim.diagnostic
			local opts = { noremap = true, silent = true }

			diag.config {
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			}
			vim.keymap.set('n', "<leader>e", diag.open_float, opts)
			vim.keymap.set('n', "[d", diag.goto_prev, opts)
			vim.keymap.set('n', "]d", diag.goto_next, opts)
			vim.keymap.set('n', "<leader>sll", diag.setloclist, opts)

			local lspc = require("lspconfig")
			local on_attach = require("tools").on_attach
			local lsp_flags = {
				-- This is the default in Nvim 0.7+
				debounce_text_changes = 150,
			}

			lspc.bashls.setup {
				on_attach = on_attach,
				flags = lsp_flags,
			}

			lspc.vimls.setup {
				on_attach = on_attach,
				flags = lsp_flags,
			}

			lspc.sumneko_lua.setup {
				settings = {
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
				on_attach = on_attach,
				flags = lsp_flags,
			}

			lspc.ccls.setup {
				on_attach = on_attach,
				flags = lsp_flags,
			}

			lspc.lemminx.setup {
				on_attach = on_attach,
				flags = lsp_flags,
			}

			lspc.dockerls.setup {
				on_attach = on_attach,
				flags = lsp_flags,
			}

			lspc.ansiblels.setup {
				on_attach = on_attach,
				flags = lsp_flags,
			}

			--ruby lsp
			lspc.solargraph.setup {
				on_attach = on_attach,
				flags = lsp_flags,
			}

			lspc.terraformls.setup {
				on_attach = on_attach,
				flags = lsp_flags,
			}

			lspc.yamlls.setup {
				on_attach = on_attach,
				flags = lsp_flags,
			}

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
	{
		'jose-elias-alvarez/null-ls.nvim',
		-- TODO: config
		config = function ()
			local null_ls = require("null-ls")

			null_ls.setup ({
				sources = {
					null_ls.builtins.code_actions.shellcheck,
					null_ls.builtins.formatting.beautysh,
					null_ls.builtins.formatting.shellharden,
					null_ls.builtins.formatting.jq
				},

				on_attach = require("tools").on_attach,
			})
		end
	}
}
