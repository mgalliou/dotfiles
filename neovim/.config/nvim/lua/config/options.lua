-- Behavior
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

-- TODO: lua implem
--[[
augroup disableautocomment
	autocmd!
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
set updatetime=100
]] --

-- UI
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmenu = true
vim.opt.colorcolumn = "81"
vim.opt.cursorline = true
-- TODO: lua implem
--vim.opt.listchars = { "space:·", "eol:↴" }
--runtime macros/justify.vim "allow paragraph justification with _j 
vim.opt.cmdheight = 0

-- Searching
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true

-- TODO: lua implem
--[[
if exists("##CmdLineEnter")
	augroup dynamic\_smartcase
		autocmd!
		autocmd CmdLineEnter : set nosmartcase
		autocmd CmdLineLeave : set smartcase
	augroup END
endif
]]--

-- Folding
vim.opt.foldmethod = "marker"

-- Filetype
vim.g.asmsyntax = 'nasm'

-- Spellchecking
vim.opt.spellsuggest= { "best", "10" }

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
