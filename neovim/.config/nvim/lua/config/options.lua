-- Behavior
vim.opt.autowrite = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.virtualedit = "all"

-- UI
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmenu = true
vim.opt.colorcolumn = "81"
vim.opt.cursorline = true
vim.opt.listchars:append("space:·")
vim.opt.listchars:append("eol:↴")
vim.cmd([[runtime macros/justify.vim]]) --allow paragraph justification with `_j`
vim.opt.cmdheight = 1

-- Searching
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Filetype
vim.g.asmsyntax = 'nasm'

-- Spellchecking
vim.opt.spellsuggest = { "best", "10" }

-- Backup
vim.opt.history = 200
vim.opt.swapfile = true
vim.opt.backup = true
vim.opt.backupdir:remove(".")
vim.opt.undofile = true
vim.opt.undodir:remove(".")

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = "(^|ss)zs.S+"
