local M = {}

M.buf_events = { "BufReadPost", "BufNewFile", "BufWritePre" }
M.borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
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

M.set_keymap_opts = function(mode, bind, action, base_opt, desc)
	local opts = base_opt

	opts.desc = desc
	vim.keymap.set(mode, bind, action, opts)
end

M.on_attach = function(ev)
	local buf = vim.lsp.buf
	local bufopts = { buffer = ev.buf }
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	local map = M.set_keymap_opts

	if client and (client.name == "tsserver" or client.name == "typescript-tools") then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client and client.supports_method("textDocument/definition", {}) then
		map("n", "gd", buf.definition, bufopts, "Go to definition")
	end
	if client and client.supports_method("textDocument/declaration") then
		map("n", "gD", buf.declaration, bufopts, "Go to declaration")
	end
	if client and client.supports_method("textDocument/implementation") then
		map("n", "gI", buf.implementation, bufopts, "Go to implementation")
	end
	if client and client.supports_method("textDocument/references") then
		map("n", "gr", buf.references, bufopts, "Reference")
	end
	map("n", "gy", buf.type_definition, bufopts, "Type definition")
	if client and client.supports_method("textDocument/signatureHelp") then
		map("n", "gK", buf.signature_help, bufopts, "Signature help")
	end
	map("i", "<C-k>", buf.signature_help, bufopts, "Signature help")
	if client and client.supports_method("textDocument/rename") then
		map("n", "<space>r", buf.rename, bufopts, "Rename symbol")
	end
	if client and client.supports_method("textDocument/codeAction") then
		map({ "n", "v" }, "<leader>a", buf.code_action, bufopts, "Code action(s)")
	end
	if client and client.supports_method("textDocument/formatting") then
		map({ "n", "v" }, "<leader>=", function()
			buf.format({ async = true })
		end, bufopts, "Format")
	end
end

M.servers = {
	lua_ls = {
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
	yamlls = {
		yaml = {
			customTags = { "!reference sequence" },
		},
		schemas = {
			["https://gitlab.com/gitlab-org/gitlab/-/blob/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
		},
	},
	helm_ls = {
		["helm-ls"] = {
			yamlls = {
				enabled = true,
			},
		},
	},
}

return M
