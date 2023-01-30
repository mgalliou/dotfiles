vim.g.mapleader = " "

--vim.o.backspace = "indent", "eol", "start"
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.virtualedit = "all"

vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0

--[[
" Behavior
augroup disableautocomment
	autocmd!
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
set updatetime=100


" UI
set noshowmode
set signcolumn=yes
set number
set relativenumber
set wildmenu
set colorcolumn=81
set cursorline
set listchars+=space:·
set listchars+=eol:↴
runtime macros/justify.vim "allow paragraph justification with _j 
if has("nvim")
	set cmdheight=0
endif

" Searching
set incsearch
set ignorecase
set smartcase
set showmatch
if exists("##CmdLineEnter")
	augroup dynamic\_smartcase
		autocmd!
		autocmd CmdLineEnter : set nosmartcase
		autocmd CmdLineLeave : set smartcase
	augroup END
endif

" Folding
set foldmethod=marker

" Filetype
let g:asmsyntax = 'nasm'

" Spellchecking
set spelllang=en,fr
set spellsuggest=best,10

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
]] --
