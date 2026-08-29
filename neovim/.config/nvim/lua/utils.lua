local M = {}

--- @type vim.api.keyset.events[]
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
M.arrows = {
	right = "",
	left = "",
	up = "",
	down = "",
}
M.debug_icons = {
	Stopped = { "", "DiagnosticWarn", "DapStoppedLine" },
	Breakpoint = { "", "DiagnosticInfo" },
	BreakpointCondition = { "", "DiagnosticInfo" },
	BreakpointRejected = { "", "DiagnosticError" },
	LogPoint = { M.arrows.right, "DiagnosticInfo" },
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

---@class LspKeymap
---@field [1] string
---@field [2] string|function
---@field mode? string|string[]
---@field desc string

-- stylua: ignore
---@type LspKeymap[]
local lsp_keymaps = {
	{ "gd", vim.lsp.buf.definition, desc = "Go to definition"},
	{ "gD", vim.lsp.buf.declaration, desc = "Go to declaration"},
	{ "gK", vim.lsp.buf.signature_help, desc = "Signature help"},
	{ "<leader>=", function() vim.lsp.buf.format({ async = true }) end, mode = { "n", "v" }, desc = "Format"},
}

---@param bufnr integer
---@param keymaps LspKeymap[]
function M.set_lsp_keymaps(bufnr, keymaps)
	for _, keymap in ipairs(keymaps) do
		vim.keymap.set(keymap.mode or "n", keymap[1], keymap[2], {
			buf = bufnr,
			desc = keymap.desc,
			silent = true,
		})
	end
end

---@param args vim.api.keyset.create_autocmd.callback_args
function M.on_attach(args)
	local client_id = args.data and args.data.client_id
	local client = client_id and vim.lsp.get_client_by_id(client_id)

	if client then
		M.set_lsp_keymaps(args.buf, lsp_keymaps)
	end
end

function M.attach_jdtls()
	local mason_dir = vim.fn.stdpath("data") .. "/mason"
	local root_dir = vim.fs.root(0, {
		"gradlew",
		"mvnw",
		"pom.xml",
		"build.gradle",
		".git",
	})

	local config = {
		cmd = { mason_dir .. "/bin/jdtls" },
		root_dir = root_dir or vim.fn.getcwd(),
		capabilities = Utils.capabilities(),
	}

	local jdtls = require("jdtls")
	jdtls.start_or_attach(config)

	---@type LspKeymap[]
	local keymaps = {
		{ "<leader>co", jdtls.organize_imports, desc = "Organize Imports" },
		{ "<leader>cv", jdtls.extract_variable, desc = "Extract Variable" },
		{
			"<leader>cv",
			"<Esc><Cmd>lua require('jdtls').extract_variable({ visual = true })<CR>",
			mode = "x",
			desc = "Extract Variable",
		},
		{ "<leader>cc", jdtls.extract_constant, desc = "Extract Constant" },
		{
			"<leader>cc",
			"<Esc><Cmd>lua require('jdtls').extract_constant({ visual = true })<CR>",
			mode = "x",
			desc = "Extract Constant",
		},
		{
			"<leader>ce",
			"<Esc><Cmd>lua require('jdtls').extract_method({ visual = true })<CR>",
			mode = "x",
			desc = "Extract Method",
		},
	}
	local bufnr = vim.api.nvim_get_current_buf()
	M.set_lsp_keymaps(bufnr, keymaps)
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
