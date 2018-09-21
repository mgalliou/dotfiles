" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: mgalliou <mgalliou@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2016/11/02 16:20:01 by mgalliou          #+#    #+#              "
"    Updated: 2018/09/21 15:38:04 by mgalliou         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

" Pathogen / Syntax / Filetype / Colorschem...

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
filetype plugin indent on
syntax on

" enable 256 color and set tmux as term if in a Windows terminal
if has("win32") && !has("gui_running")
	set term=xterm
	set t_Co=256
	colorscheme gruvbox
"	let &t_AB="\e[48;5;%dm"
"	let &t_AF="\e[38;5;%dm"
" enable 256 color in capable terminals 
elseif (-1 < stridx($TERM, "256"))
	set t_Co=256
	colorscheme gruvbox
else
	colorscheme default
endif
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

" Indentation
set autoindent
set tabstop=4
set softtabstop=0
set noexpandtab
set shiftwidth=4

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

" **************************************************************************** "
" Mappings {{{

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
" reload vimrc
nnoremap <leader>r <ESC>:so $MYVIMRC<CR>

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

" Backup
set history=200
set noswapfile

if has("win32")
	set backup backupdir=~/vimfiles/backup/
	set undofile undodir=~/vimfiles/backup/undo/
else
	set backup backupdir=~/.vim/backup/
	set undofile undodir=~/.vim/backup/undo/
endif

" **************************************************************************** "
" Statusline {{{

set laststatus=2
set ruler

let g:currentmode=
			\{
			\'n'  : 'Normal',
			\'no' : 'N-Operator Pending',
			\'v'  : 'Visual',
			\'V'  : 'V-Line',
			\'' : 'V-Block',
			\'s'  : 'Select',
			\'S'  : 'S-Line',
			\'' : 'S-Block',
			\'i'  : 'Insert',
			\'R'  : 'Replace',
			\'Rv' : 'V-Replace',
			\'c'  : 'Command',
			\'cv' : 'Vim Ex',
			\'ce' : 'Ex',
			\'r'  : 'Prompt',
			\'rm' : 'More',
			\'r?' : 'Confirm',
			\'!'  : 'Shell',
			\}

function! SetStatusLine(cur)
	"if !(exists("b:NERDTree") && b:NERDTree.isTabTree())
	setl statusline=
	setl statusline+=%(%1*%3{&filetype!='help'?bufnr('%'):''}\ %) "buffer nb
	if (a:cur)
		setl statusline+=%0*\  "separator
		setl statusline+=%(%4*\ %{toupper(g:currentmode[mode()])}\ %) "mode
	endif
	setl statusline+=%0*\  "separator
	setl statusline+=%(%2*\ %f\ %) "filepath
	setl statusline+=%<
	setl statusline+=%0*\  "separator
	setl statusline+=%(%3*%{&modified?'\ +\ ':''}%2*%) "modif indicator
	setl statusline+=%{&readonly?'\ #\ ':''} "read-only indicator
	setl statusline+=%(%h\ %) "help indicator
	setl statusline+=%0*%=
	setl statusline+=%(%2*\ %p\ %%\ %)
	setl statusline+=%0*\  "separator
	setl statusline+=%(%2*\ %{''!=#&filetype?&filetype:'none'}\ %)
	setl statusline+=%0*\  "separator
	"endif
endfunction

highlight link User1 PmenuSel
highlight link User2 ToolLine
highlight link User3 DiffText
highlight link User4 DiffChange

if version >= 700
	autocmd InsertLeave * highlight link User4 DiffChange
	autocmd InsertEnter * highlight link User4 DiffAdd
	autocmd VimEnter,WinEnter,BufEnter * call SetStatusLine(1)
	autocmd WinLeave * call SetStatusLine(0)
endif
"}}},
" **************************************************************************** "

" Plugins settings

"	NERDTree
if exists("*NERDTree")
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
	let g:NERDTreeWinSize = 29
endif

"	NERDCommenter
if exists("g:NERDDefaultAlign")
	let g:NERDDefaultAlign = 'left'
endif

"	Hardmode

if exists("*ToggleHardMode")
	nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
endif
