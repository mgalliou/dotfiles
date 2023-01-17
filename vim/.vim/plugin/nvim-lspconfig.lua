local function on_attach(client, bufnr)
	local buf = vim.lsp.buf

	local function quick_code_action()
		buf.code_action {
			context = {
				only = {
					"quickfix",
					"refactor",
				},
			},
			apply = true,
		}
	end

	local km = vim.keymap
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	km.set('n', "<leader>dc", buf.declaration, bufopts)
	km.set('n', "<leader>df", buf.definition, bufopts)
	km.set('n', "<leader>hv", buf.hover, bufopts)
	km.set('n', "<leader>ip", buf.implementation, bufopts)
	km.set('n', "<leader><C-k>", buf.signature_help, bufopts)
	km.set('n', "<leader>wa", buf.add_workspace_folder, bufopts)
	km.set('n', "<leader>wr", buf.remove_workspace_folder, bufopts)
	km.set('n', "<leader>wl", function() print(vim.inspect(buf.list_workspace_folders())) end, bufopts)
	km.set('n', "<leader>D", buf.type_definition, bufopts)
	--  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	km.set({ 'n', 'v' }, "<leader>ca", buf.code_action, bufopts)
	km.set('n', "<leader>qf", quick_code_action, bufopts)
	km.set('n', 'gr', buf.references, bufopts)
	km.set({ 'n', 'v' }, "<leader>fm", function() buf.format { async = true } end, bufopts)
end

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

require("mason").setup {}
require("mason-lspconfig").setup()
local lspc = require("lspconfig")
local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

lspc.vimls.setup {
	on_attach = on_attach,
	flags = lsp_flags,
}

lspc.sumneko_lua.setup {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					vim.api.nvim_get_runtime_file("", true),
					"/usr/share/awesome/lib",
				},
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
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
