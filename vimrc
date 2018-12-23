" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: mgalliou <mgalliou@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2016/11/02 16:20:01 by mgalliou          #+#    #+#              "
"    Updated: 2018/12/23 16:06:40 by mgalliou         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

" **************************************************************************** "
" Pathogen / Syntax / Filetype / Colorscheme... {{{
" **************************************************************************** "

" Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Colorsheme
filetype plugin indent on
syntax on
colorscheme gruvbox

" enable 256 color and set tmux as term if in a Windows terminal {{{
if has("win32") && !has("gui_running")
	set term=xterm
	set t_Co=256
	colorscheme gruvbox
"	let &t_AB="\e[48;5;%dm"
"	let &t_AF="\e[38;5;%dm"
" enable 256 color in capable terminals 
elseif (-1 < stridx("256", $TERM))
	set t_Co=256
elseif (-1 < stridx("xterm", $TERM))
	colorscheme default
endif
"}}},

set background=dark

" set font in gvim
if has("gui_running")
	set guifont=Dina
endif

" Behavior
set hidden
set mouse=a
set mousehide
set backspace=indent,eol,start
set scrolloff=4
set sidescrolloff=4
set splitright
set splitbelow
" disable auto comment:
set formatoptions-=cro
set nowrap

" Indentation
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=0
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2

"UI
set wildmenu
set textwidth=80
set colorcolumn=81
set number
set noshowmode
set showcmd
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,eol:\|
"

" Bell
set noerrorbells
"set visualbell

" Searching
"set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Folding
set foldmethod=marker

"}}},
" **************************************************************************** "

" **************************************************************************** "
" Mappings {{{
" **************************************************************************** "

" reload vimrc
nnoremap <leader>r <ESC>:so $MYVIMRC<CR>
" save
nnoremap <leader>q :q<CR>
" quit
nnoremap <leader><space> :w<CR>
" remove highlights
nnoremap <leader>l :nohl<CR>
" remove trailing whitespace
nnoremap <leader>w m`:%s/\s\+$//<CR>:let @/=''<CR>``
" toggle invisible chars
nnoremap <leader>i :set list!<CR>
" toggle relativenumber
nnoremap <leader>n :set relativenumber!<CR>
" explore netrw
nnoremap <leader>e <ESC>:Explore<CR>
nnoremap <leader>v <ESC>:Vexplore<CR>
nnoremap <leader>s <ESC>:Sexplore<CR>
nnoremap <leader>t <ESC>:Texplore<CR>
" save files with root privileges.
cmap w!! w !sudo tee % >/dev/null

" autoclosing mappings
" inoremap ( ()<Left>
" inoremap ) ()<Left>
" inoremap { {}<Left>
" inoremap } {}<Left>
" inoremap [ []<Left>
" inoremap ] []<Left>
" inoremap > <><Left>
" inoremap < <><Left>
" inoremap " ""<Left>
" inoremap ' ''<Left>

"}}},
" **************************************************************************** "

" **************************************************************************** "
" Backup {{{
" **************************************************************************** "

set history=200
set noswapfile

if has("win32")
	set backup backupdir=~/vimfiles/backup/
	set undofile undodir=~/vimfiles/backup/undo/
else
	set backup backupdir=~/.vim/backup/
	set undofile undodir=~/.vim/backup/undo/
endif

"}}},
" **************************************************************************** "

" **************************************************************************** "
" Plugins settings {{{
" **************************************************************************** "

" define a group `vimrc` and initialize.
augroup vimrc
  autocmd!
augroup END

" NERDTree
if exists("*NERDTree")
	autocmd vimrc StdinReadPre * let s:std_in=1
	autocmd vimrc VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	autocmd vimrc VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
	let g:NERDTreeWinSize = 29
endif

" NERDCommenter
if exists("g:NERDDefaultAlign")
	let g:NERDDefaultAlign = 'left'
endif

" Hardmode
if exists("*ToggleHardMode")
	nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
endif

" rainbow
if exists("RainbowToggle")
	nnoremap <leader>b <Esc>:RainbowToggle<CR>
endif

" IndentLine
"let g:indentLine_char = '|'


"}}},
" **************************************************************************** "
