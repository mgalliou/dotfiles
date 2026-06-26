local M = {}

M.buf_events = { "BufReadPost", "BufNewFile", "BufWritePre" }
M.borderchars = {
	default = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	bottom_linked = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
	top_linked = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
}
M.kind_icons = {
	Class = " ",
	Color = " ",
	Constant = " ",
	Constructor = " ",
	Enum = " ",
	EnumMember = " ",
	Event = " ",
	Field = " ",
	File = " ",
	Folder = " ",
	Function = "󰡱 ",
	Interface = " ",
	Keyword = " ",
	Method = " ",
	Module = " ",
	Operator = " ",
	Property = " ",
	Reference = " ",
	Snippet = " ",
	Struct = " ",
	Text = " ",
	TypeParameter = "󰉺 ",
	Unit = "󰅲 ",
	Value = " ",
	Variable = " ",
}
M.symbol_types = {
	"Class",
	"Function",
	"Method",
	"Constructor",
	"Interface",
	"Module",
	"Struct",
	"Trait",
	"Field",
	"Property",
}

M.is_termux = function()
	return vim.env.TERMUX_VERSION ~= nil
end

M.PluginIsLoaded = function(plugin)
	if 0 == vim.fn["tools#PluginIsLoaded"](plugin) then
		return false
	end
	return true
end

M.config_custom_server = function(name, cmd, filetypes, root_pattern)
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

---@alias LazyKeysLspSpec LazyKeysSpec|{capa?:string|string[], cond?:fun():boolean}
---@alias LazyKeysLsp LazyKeys|{capa?:string|string[], cond?:fun():boolean}

---@type LazyKeysLspSpec[]
local keymaps_specs = {
	{ "gd", vim.lsp.buf.definition, desc = "Go to definition", capa = "definition" },
	{ "gD", vim.lsp.buf.declaration, desc = "Go to declaration", capa = "declaration" },
	{ "gI", vim.lsp.buf.implementation, desc = "Go to implementation", capa = "implementation" },
	{ "gr", vim.lsp.buf.references, desc = "Reference", capa = "references" },
	{ "gy", vim.lsp.buf.type_definition, desc = "Type definition" },
	{ "gK", vim.lsp.buf.signature_help, desc = "Signature help", capa = "signatureHelp" },
	{ "<C-k>", vim.lsp.buf.signature_help, desc = "Signature help", mode = "i", capa = "signatureHelp" },
	{ "<space>r", vim.lsp.buf.rename, desc = "Rename symbol", capa = "rename" },
	{ "<leader>a", vim.lsp.buf.code_action, mode = { "n", "v" }, desc = "Code action(s)", capa = "codeAction" },
	{
		"<leader>=",
		function()
			vim.lsp.buf.format({ async = true })
		end,
		mode = { "n", "v" },
		desc = "Format",
		capa = "formatting",
	},
}

---@param bufnr integer
---@param client vim.lsp.Client
local function map_keys(bufnr, client)
	local Keys = require("lazy.core.handler.keys")
	local keymaps = Keys.resolve(keymaps_specs)

	for _, key in pairs(keymaps) do
		local opts = Keys.opts(key) --[[@as vim.keymap.set.Opts]]
		if client and opts.capa and client:supports_method("textDocument/" .. opts.capa, bufnr) then
			opts.cond = nil ---@diagnostic disable-line: inject-field
			opts.capa = nil ---@diagnostic disable-line: inject-field
			opts.silent = opts.silent ~= false
			opts.buffer = bufnr
			vim.keymap.set(key.mode or "n", key.lhs, key.rhs, opts)
		end
	end
end

---@param args vim.api.keyset.create_autocmd.callback_args
M.on_attach = function(args)
	---@type integer
	local bufnr = args.buf
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	for _, client in ipairs(clients) do
		map_keys(bufnr, client)
	end
end

M.capabilities = function()
	return vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		require("blink.cmp").get_lsp_capabilities(),
		{
			workspace = {
				didChangeWatchedFiles = {
					dynamicRegistration = true,
				},
			},
		}
	)
end

return M
