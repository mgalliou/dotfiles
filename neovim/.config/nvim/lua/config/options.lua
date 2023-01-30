vim.g.mapleader = " "

--vim.o.backspace = "indent", "eol", "start"
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.virtualedit = "all"

-- Behavior
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0

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
-- TODO: lua implem
--vim.o.spelllang = { "en" }
vim.o.spellsuggest=best,10

-- TODO: finish migration
--[[
" Backup
set history=200
set noswapfile
set backup
set backupdir-=.
set undofile
set undodir-=.

" netrw 
let g:netrw_banner = 0
let g:netrw_liststyle = 3
"let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

"}}}
" Mappings {{{

let mapleader = " "
" reload vimrc
nnoremap <leader>rl <CMD>so $MYVIMRC<CR>
" remove highlights
nnoremap <leader>hl <CMD>nohl<CR>
" remove trailing white spaces
nnoremap <leader>ws m`:%s/\s\+$//<CR>:let @/=''<CR>``:w<CR>
" toggle invisible chars
nnoremap <leader>lst <CMD>set list!<CR>
" save files with root privileges
cmap w!! w !sudo tee % >/dev/null

nnoremap <leader>sc <CMD>set spell!<CR>
nnoremap <leader>ln <CMD>call tools#ToggleLineNumberMode()<CR>

"}}}
]]--
