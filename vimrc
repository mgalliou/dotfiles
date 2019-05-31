" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: mgalliou <mgalliou@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2016/11/02 16:20:01 by mgalliou          #+#    #+#              "
"    Updated: 2019/05/27 20:39:11 by mgalliou         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

" **************************************************************************** "
" Syntax / Filetype / Colorscheme... {{{
" **************************************************************************** "

" Colorsheme
filetype plugin indent on
syntax on
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
set background=dark

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
set textwidth=80
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

" filetype
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

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
" toggle relative line number
nnoremap <leader>n <ESC>:call ToggleLineNumberMode()<CR>
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

function! SetPluginSettings()
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

	" rainbow
	if exists(":RainbowToggle")
		let g:rainbow_active = 1
		nnoremap <leader>b <ESC>:RainbowToggle<CR>
	endif

	" IndentLine
	"let g:indentLine_char = '|'

	" Ale
	let g:ale_c_clang_options = '-std=c11 -Wall -Wextra -Werror -Iinclude -Ilibft/include'
	let g:ale_c_gcc_options = '-std=c11 -Wall -Wextra -Werror -Iinclude -Ilibft/include'

endfunction

autocmd VimEnter * call SetPluginSettings()

"}}},
" **************************************************************************** "
