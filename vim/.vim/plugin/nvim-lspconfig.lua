local function quick_code_action()
	vim.lsp.buf.code_action {
		context = {
			only = {
				"quickfix",
				"refactor",
			},
		},
		apply = true,
	}
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>sll', vim.diagnostic.setloclist, opts)


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', '<leader>dc', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', '<leader>df', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', '<leader>hv', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', '<leader>ip', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<leader><C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	--  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', "<leader>qf", quick_code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set({'n', 'v'}, '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

require("rust-tools").setup {
	server = {
		on_attach = on_attach,
	},
}
require('lspconfig').vimls.setup {
	on_attach = on_attach,
	flags = lsp_flags,
}
require('lspconfig').solargraph.setup {
	on_attach = on_attach,
	flags = lsp_flags,
}
require('lspconfig').sumneko_lua.setup {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					vim.api.nvim_get_runtime_file("", true),
                    "/usr/share/awesome/lib",
				}
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
	on_attach = on_attach,
	flags = lsp_flags
}
require('lspconfig').ccls.setup {
	on_attach = on_attach,
    flags = lsp_flags
}
require('lspconfig').ansiblels.setup {
	on_attach = on_attach,
	flags = lsp_flags
}

--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config {
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
}

local icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = " ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
	kinds[i] = icons[kind] or kind
end
