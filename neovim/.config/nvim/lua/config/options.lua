local g = vim.g
local o = vim.opt

-- Behavior
o.autowrite = true
o.autoindent = true
o.tabstop = 4
o.shiftwidth = 0
o.softtabstop = -1
o.scrolloff = 4
o.sidescrolloff = 4
o.splitright = true
o.splitbelow = true
o.virtualedit = "block"
o.linebreak = true
--o.clipboard:append("unnamedplus")

-- UI
o.termguicolors = true
o.showmode = false
o.signcolumn = "auto"
o.number = true
o.relativenumber = true
o.wildmenu = true
o.colorcolumn = "81"
o.cursorline = true
o.listchars:append("space:·")
o.listchars:append("eol:↴")
vim.cmd([[runtime macros/justify.vim]]) --allow paragraph justification with `_j`
o.cmdheight = 1
vim.cmd([[colorscheme gruvbox]])

-- Searching
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.showmatch = true

-- Folding
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldenable = false

-- Filetype
g.asmsyntax = "nasm"

-- Spellchecking
o.spellsuggest = { "best", "10" }

-- Backup
o.history = 200
o.swapfile = true
o.backup = true
o.backupdir:remove(".")
o.undofile = true
o.undodir:remove(".")

-- netrw
g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_list_hide = "(^|ss)zs.S+"

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "html", "css", "javascript", "typescript", "toml", "helm", "markdown", "json", "jsonc" },
	callback = function()
		vim.opt_local.tabstop = 2
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "toml", "helm", "markdown" },
	callback = function()
		vim.opt_local.expandtab = true
	end,
})
vim.g.markdown_recommended_style = 0
