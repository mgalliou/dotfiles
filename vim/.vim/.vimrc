" Plugins {{{

" auto install vimplug
if !has('win32') && empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'dstein64/vim-startuptime'
Plug 'felixhummel/setcolors.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'srcery-colors/srcery-vim'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'leafgarland/typescript-vim',
Plug 'cespare/vim-toml',
Plug 'dag/vim-fish',
Plug 'vim-scripts/tf2.vim', { 'for': 'tf2' }
Plug 'tbastos/vim-lua',
Plug 'tmux-plugins/vim-tmux',
"Plug 'tpope/vim-classpath', { 'for': 'java' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'luochen1990/rainbow'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/gutentags_plus'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
if !has("nvim")
	Plug 'dense-analysis/ale'
endif
if has("nvim")
	Plug 'nvim-lua/plenary.nvim'
	Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
	Plug 'DanilaMihailov/beacon.nvim'
	Plug 'lukas-reineke/indent-blankline.nvim'
	Plug 'xiyaowong/virtcolumn.nvim'
	Plug 'folke/todo-comments.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'kosayoda/nvim-lightbulb'
	Plug 'ThePrimeagen/harpoon'
endif
call plug#end()

"}}}
" Colorscheme... {{{

" Colorsheme
if tools#PluginIsLoaded("gruvbox")
	set background=dark
	let g:gruvbox_italic=1
	let g:gruvbox_contrast_dark='soft'
	let g:gruvbox_contrast_light='soft'
	let g:gruvbox_invert_signs=1
endif
colorscheme gruvbox

" enable 256 color and set tmux as term if in a Windows terminal {{{
" TODO: check if this is still needed
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
"}}},

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
" set nowrap
set updatetime=100

" Indentation
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=0
augroup indentation
augroup END

" UI
set wildmenu
"set textwidth=80
set colorcolumn=81
set cursorline
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,eol:\|
" allow paragraph justification with _j
runtime macros/justify.vim


" Bell
"set noerrorbells
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
let g:asmsyntax = 'nasm'

" Spellcheking
" TODO: add mapping for toggling spellchecking
" set spell
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
let g:netrw_keepdir = 0
"let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

"}}}
" Mappings {{{

let mapleader = " "
" reload vimrc
nnoremap <leader>r <CMD>so $MYVIMRC<CR>
" quit
"nnoremap <leader>q <CMD>q<CR>
" save
"nnoremap <leader><space> <CMD>w<CR>
" remove highlights
nnoremap <leader>l <CMD>nohl<CR>
" remove trailing whitespace
nnoremap <leader>w m`:%s/\s\+$//<CR>:let @/=''<CR>``:w<CR>
" toggle invisible chars
nnoremap <leader>i <CMD>set list!<CR>
" explore netrw
nnoremap <leader>e <CMD>Explore<CR>
nnoremap <leader>v <CMD>Vexplore<CR>
nnoremap <leader>s <CMD>Sexplore<CR>
nnoremap <leader>t <CMD>Texplore<CR>
" save files with root privileges.
cmap w!! w !sudo tee % >/dev/null

nnoremap <leader>n <CMD>call tools#ToggleLineNumberMode()<CR>

"}}}
