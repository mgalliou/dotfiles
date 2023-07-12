local g = vim.g
local o = vim.opt

-- Behavior
o.autowrite = true
o.backspace = { "indent", "eol", "start" }
o.autoindent = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 0
o.scrolloff = 4
o.sidescrolloff = 4
o.splitright = true
o.splitbelow = true
o.virtualedit = "all"
o.clipboard:append("unnamedplus")

-- UI
o.termguicolors = true
o.showmode = false
o.signcolumn = "yes"
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
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = false

-- Filetype
g.asmsyntax = 'nasm'

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
