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
Plug 'pearofducks/ansible-vim'
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
if !has("nvim")
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'dense-analysis/ale'
elseif has("nvim")
	Plug 'nvim-lua/plenary.nvim'
	Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
	Plug 'DanilaMihailov/beacon.nvim'
	Plug 'lukas-reineke/indent-blankline.nvim'
	Plug 'xiyaowong/virtcolumn.nvim'
	Plug 'folke/todo-comments.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-treesitter/nvim-treesitter-context'
	Plug 'kosayoda/nvim-lightbulb'
	"Plug 'windwp/nvim-autopairs'
	Plug 'filipdutescu/renamer.nvim', { 'branch': 'master' }
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
	Plug 'ThePrimeagen/harpoon'
endif
call plug#end()

"}}}
" Options ... {{{

" Colorscheme
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

" Behavior
set backspace=indent,eol,start
set scrolloff=4
set sidescrolloff=4
set splitright
set splitbelow
augroup disableautocomment
	autocmd!
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
set updatetime=100

" Indentation
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=0

" UI
set number
set relativenumber
set wildmenu
set colorcolumn=81
set cursorline
set list
set listchars+=space:·
set listchars+=eol:↴
runtime macros/justify.vim "allow paragraph justification with _j 

" Searching
set incsearch
set ignorecase
set smartcase
set showmatch

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
let g:netrw_keepdir = 0
"let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

"}}}
" Mappings {{{

let mapleader = " "
" reload vimrc
nnoremap <leader>r <CMD>so $MYVIMRC<CR>
" remove highlights
nnoremap <leader>l <CMD>nohl<CR>
" remove trailing white spaces
nnoremap <leader>w m`:%s/\s\+$//<CR>:let @/=''<CR>``:w<CR>
" toggle invisible chars
nnoremap <leader>i <CMD>set list!<CR>
" explore netrw
nnoremap <leader>e <CMD>Explore<CR>
nnoremap <leader>v <CMD>Vexplore<CR>
nnoremap <leader>s <CMD>Sexplore<CR>
nnoremap <leader>t <CMD>Texplore<CR>
" save files with root privileges
cmap w!! w !sudo tee % >/dev/null

nnoremap <leader>sc <CMD>set spell!<CR>
nnoremap <leader>n <CMD>call tools#ToggleLineNumberMode()<CR>

"}}}
