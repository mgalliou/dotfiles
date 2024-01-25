local M = {}

function M.PluginIsLoaded(plugin)
	if 0 == vim.fn["tools#PluginIsLoaded"](plugin) then
		return false
	end
	return true
end

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
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	local function quick_code_action()
		buf.code_action({
			context = {
				only = {
					"quickfix",
					"refactor",
				},
			},
			apply = true,
		})
	end

	vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
	local km = M.set_keymap_opts
	km("n", "<leader>gc", buf.declaration, bufopts, "Go to declaration")
	km("n", "<leader>gd", buf.definition,  bufopts,"Go to definition")
	km("n", "<leader>H", buf.hover, bufopts, "Hover symbol")
	km("n", "<leader>gi", buf.implementation, bufopts, "Go to implementation")
	km("n", "<leader><C-k>", buf.signature_help, bufopts, "Signature help")
	km("n", "<leader>wa", buf.add_workspace_folder, bufopts, "Add workspace folder")
	km("n", "<leader>wr", buf.remove_workspace_folder, bufopts, "Remove workspace folder")
	km("n", "<leader>wl", function()
		print(vim.inspect(buf.list_workspace_folders()))
	end, bufopts, "List workspace folder")
	km("n", "<leader>gy", buf.type_definition, bufopts, "Type definition")
	km('n', '<space>r', buf.rename, bufopts, "Rename symbol")
	km({ "n", "v" }, "<leader>a", buf.code_action, bufopts, "Code action(s)")
	km("n", "<leader>qf", quick_code_action, bufopts, "Quick code action")
	km("n", "gr", buf.references, bufopts, "Reference")
	km({ "n", "v" }, "<leader>=", function()
		buf.format({ async = true })
	end, bufopts, "Format")
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
}

return M
