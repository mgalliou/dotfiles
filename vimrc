" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: mgalliou <mgalliou@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2016/11/02 16:20:01 by mgalliou          #+#    #+#              "
"    Updated: 2020/03/13 12:22:02 by mgalliou         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

" Plugins {{{

function! PlugAle()
	Plug 'w0rp/ale',  
	let g:ale_linters =  {'c': ['clang', 'gcc']}
	let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
	let g:ale_c_clang_options = '-Wall -Wextra -Werror -Iinclude -Ilibft/include -Ilibftest/include'
	let g:ale_c_gcc_options = '-Wall -Wextra -Werror -Iinclude -Ilibft/include -Ilibftest/include'
	" TODO: add OS check
	let g:ale_nasm_nasm_options = '-f macho64'
endfunction

function! PlugIndentLine()
	Plug 'Yggdroot/indentLine'
	let g:indentLine_char = '|'
endfunction
	
function! PlugRainbow()
	Plug 'luochen1990/rainbow'
	let g:rainbow_active = 1
	nnoremap <leader>b <ESC>:RainbowToggle<CR>
endfunction

function! PlugFZF()
	Plug 'junegunn/fzf.vim'
	set rtp+=/usr/local/opt/fzf
endfunction

function! PlugNERDTree()
	Plug 'preservim/nerdtree'
	autocmd vimrc StdinReadPre * let s:std_in=1
	autocmd vimrc VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	autocmd vimrc VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
	let g:NERDTreeWinSize = 29
endfunction

function! PlugNERDCommenter()
	Plug 'preservim/nerdcommenter'
	let g:NERDDefaultAlign = 'left'
endfunction

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'felixhummel/setcolors.vim'
Plug 'morhetz/gruvbox'
Plug 'leafgarland/typescript-vim'
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'
Plug 'vim-scripts/tf2.vim'
Plug 'tbastos/vim-lua'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
call PlugRainbow()
"call PlugIndentLine()
"call PlugNERDTree()
"call PlugNERDCommenter()
call PlugAle()
"Plug 'Shougo/deoplete.nvim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
call PlugFZF()
call plug#helptags()
call plug#end()
"}}}

" Syntax / Filetype / Colorscheme... {{{

" Colorsheme
filetype plugin indent on
syntax on
try
	let g:gruvbox_italic=1
	let g:gruvbox_contrast_dark='hard'
	let g:gruvbox_contrast_light='hard'
	let g:gruvbox_number_column="bg2"
	"let g:gruvbox_improved_strings=1
	let g:gruvbox_improved_warnings=1
	let g:gruvbox_invert_signs=1
	colorscheme gruvbox
	set background=dark
endtry

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

" set font in gvim
if has("gui_running")
	set guifont=InputMonoCondensed
endif

" Behavior
set hidden
"set mouse=a
set mousehide
set backspace=indent,eol,start
set scrolloff=4
set sidescrolloff=4
set splitright
set splitbelow
" disable auto comment:
set formatoptions-=cro
set nowrap
set updatetime=100

" Indentation
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=0
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2

" UI
set wildmenu
"set textwidth=80
set colorcolumn=81
set noshowmode
set showcmd
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,eol:\|

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

" Filetype
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

let g:asmsyntax = 'nasm'
"}}}

" Mappings {{{

" reload vimrc
nnoremap <leader>r <ESC>:so $MYVIMRC<CR>
" save
nnoremap <leader>q :q<CR>
" quit
nnoremap <leader><space> :w<CR>
" remove highlights
nnoremap <leader>l :nohl<CR>
" remove trailing whitespace
nnoremap <leader>w m`:%s/\s\+$//<CR>:let @/=''<CR>``:w<CR>
" toggle invisible chars
nnoremap <leader>i :set list!<CR>
" explore netrw
nnoremap <leader>e <ESC>:Explore<CR>
nnoremap <leader>v <ESC>:Vexplore<CR>
nnoremap <leader>s <ESC>:Sexplore<CR>
nnoremap <leader>t <ESC>:Texplore<CR>
" save files with root privileges.
cmap w!! w !sudo tee % >/dev/null

function! ToggleLineNumberMode()
	if &number == 0 && &relativenumber == 0
		set number
	elseif &number != 0 && &relativenumber == 0
		set nonumber
		set relativenumber
	elseif &relativenumber != 0
		set norelativenumber
	endif
endfunction
nnoremap <leader>n <ESC>:call ToggleLineNumberMode()<CR>
"}}}

" Backup {{{

set history=200
set noswapfile

if has("win32")
	set backup backupdir=~/vimfiles/backup/
	set undofile undodir=~/vimfiles/backup/undo/
else
	set backup backupdir=~/.vim/backup/
	set undofile undodir=~/.vim/backup/undo/
endif
"}}}
