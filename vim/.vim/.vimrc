" Plugins {{{

" auto install vimplug
if !has('win32') && empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'felixhummel/setcolors.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'srcery-colors/srcery-vim'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'leafgarland/typescript-vim', { 'for': 'typesript' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'vim-scripts/tf2.vim', { 'for': 'tf2' }
Plug 'tbastos/vim-lua', { 'for': 'lua' }
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
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
	Plug 'ThePrimeagen/harpoon'
endif
call plug#helptags()
call plug#end()

"}}}
" Syntax / Filetype / Colorscheme... {{{

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

function! ToggleLineNumberMode()
	if &number == 0 && &relativenumber == 0
		set number
	elseif &number != 0 && &relativenumber == 0
		set number
		set relativenumber
	elseif &relativenumber != 0
		set nonumber
		set norelativenumber
	endif
endfunction
nnoremap <leader>n <CMD>call ToggleLineNumberMode()<CR>

if tools#PluginIsLoaded("fzf.vim")
	nnoremap <leader>f <CMD>Files<CR>
endif

if tools#PluginIsLoaded("harpoon")
	nnoremap <leader>Ha <CMD>lua require("harpoon.mark").add_file()<CR>
	nnoremap <leader>Ht <CMD>lua require("harpoon.ui").toggle_quick_menu()<CR>
	nnoremap <leader><leader>h <CMD>lua require("harpoon.ui").nav_file(vim.v.count1)<CR>
endif

if tools#PluginIsLoaded("ale")
	nnoremap <leader>ar <CMD>ALERename<CR>
endif

"}}}
" Merlin {{{

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
"let s:opam_share_dir = system("opam var share")
"let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')
"
"let s:opam_configuration = {}
"
"function! OpamConfOcpIndent()
"  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
"endfunction
"let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')
"
"function! OpamConfOcpIndex()
"  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
"endfunction
"let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')
"
"function! OpamConfMerlin()
"  let l:dir = s:opam_share_dir . "/merlin/vim"
"  execute "set rtp+=" . l:dir
"endfunction
"let s:opam_configuration['merlin'] = function('OpamConfMerlin')
"
"let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
"let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
"let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
"for tool in s:opam_packages
"  " Respect package order (merlin should be after ocp-index)
"  if count(s:opam_available_tools, tool) > 0
"    call s:opam_configuration[tool]()
"  endif
"endfor
"" ## end of OPAM user-setup addition for vim / base ## keep this line
"" ## added by OPAM user-setup for vim / ocp-indent ## aaf2f605ffa0e7e1876b49382bf5954b ## you can edit, but keep this line
"if count(s:opam_available_tools,"ocp-indent") == 0
"  source "/sgoinfre/goinfre/Perso/mgalliou/.opam/default/share/ocp-indent/vim/indent/ocaml.vim"
"endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
"}}}
