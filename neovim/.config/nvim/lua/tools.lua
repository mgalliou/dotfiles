local M = {}

function M.PluginIsLoaded(plugin)
	if 0 == vim.fn["tools#PluginIsLoaded"](plugin) then
		return false
	end
	return true
end

M.borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }

M.kind_icons = {
	Class = "ﴯ ",
	Color = " ",
	Constant = " ",
	Constructor = " ",
	Enum = " ",
	EnumMember = " ",
	Event = " ",
	Field = " ",
	File = " ",
	Folder = " ",
	Function = " ",
	Interface = " ",
	Keyword = " ",
	Method = "ƒ ",
	Module = " ",
	Operator = " ",
	Property = " ",
	Reference = " ",
	Snippet = " ",
	Struct = " ",
	Text = " ",
	TypeParameter = " ",
	Unit = " ",
	Value = " ",
	Variable = " ",
}

M.on_attach = function(client, bufnr)
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
	km.set('n', "<leader>gc", buf.declaration, bufopts)
	km.set('n', "<leader>gd", buf.definition, bufopts)
	km.set('n', "<leader>h", buf.hover, bufopts)
	km.set('n', "<leader>gi", buf.implementation, bufopts)
	km.set('n', "<leader><C-k>", buf.signature_help, bufopts)
	km.set('n', "<leader>wa", buf.add_workspace_folder, bufopts)
	km.set('n', "<leader>wr", buf.remove_workspace_folder, bufopts)
	km.set('n', "<leader>wl", function() print(vim.inspect(buf.list_workspace_folders())) end, bufopts)
	km.set('n', "<leader>gy", buf.type_definition, bufopts)
	--  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	km.set({ 'n', 'v' }, "<leader>a", buf.code_action, bufopts)
	km.set('n', "<leader>qf", quick_code_action, bufopts)
	km.set('n', 'gr', buf.references, bufopts)
	km.set({ 'n', 'v' }, "<leader>=", function() buf.format { async = true } end, bufopts)
end

return M
