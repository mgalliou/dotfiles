" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: mgalliou <mgalliou@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2016/11/02 16:20:01 by mgalliou          #+#    #+#              "
"    Updated: 2022/07/18 12:18:32 by mgalliou         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "


" Plugins {{{

" auto install vimplug
if !has('win32') && empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! s:PluginIsLoaded(plugin)
	return has_key(g:plugs, a:plugin)
endfunction

function! s:PlugAle()
	let g:ale_completion_enabled = 1
	Plug 'dense-analysis/ale',
	let g:ale_linters =  {
	 			\'c': ['clang', 'gcc']
	 			\}
	 let g:ale_fixers = {
	 			\'*': ['remove_trailing_lines', 'trim_whitespace']
	 			\}
	let g:ale_c_cc_options = '-Wall -Wextra -Werror -Iinclude -Ilibft/include -Ilibftest/include'
	" TODO: add OS check
	let g:ale_nasm_nasm_options = '-f macho64'
endfunction

function! s:PlugIndentLine()
	Plug 'Yggdroot/indentLine'
	let g:indentLine_char = '|'
endfunction

function! s:PlugRainbow()
	Plug 'luochen1990/rainbow'
	let g:rainbow_active = 1
	nnoremap <leader>b <ESC>:RainbowToggle<CR>
endfunction

function! s:PlugFZF()
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	"set rtp+=/usr/local/opt/fzf
endfunction

function! s:PlugGutentags_Plus()
	Plug 'skywind3000/gutentags_plus'
	" enable gtags module
	let g:gutentags_modules = ['ctags', 'gtags_cscope']
	" config project root markers.
	let g:gutentags_project_root = ['.root']
	" generate datebases in my cache directory, prevent gtags files polluting my project
	let g:gutentags_cache_dir = expand('~/.cache/tags')
endfunction

function! s:PlugGutentags()
	Plug 'ludovicchabant/vim-gutentags'
	if 1 != executable("ctags")
		let g:gutentags_enabled = 0
	endif
	call s:PlugGutentags_Plus()
endfunction

function! s:PlugVimspector()
	Plug 'puremourning/vimspector'
	let g:vimspector_enable_mappings = 'HUMAN'
	"packadd! vimspector
endfunction

function! s:PlugUltiSnips()
	let g:UltiSnipsExpandTrigger="<tab>"
	let g:UltiSnipsListSnippets="<s-tab>"
	let g:UltiSnipsJumpForwardTrigger="<c-b>"
	let g:UltiSnipsJumpBackwardTrigger="<c-z>"
endfunction

function! s:PlugLightline()
	Plug 'itchyny/lightline.vim'
	Plug 'shinchu/lightline-gruvbox.vim'
	set laststatus=2
	set noshowmode
	let g:lightline = {}
	"let g:lightline.colorscheme = 'gruvbox'
	let g:lightline.mode_map = {
				\ 'n' : 'N',
				\ 'i' : 'I',
				\ 'R' : 'R',
				\ 'v' : 'V',
				\ 'V' : 'VL',
				\ "\<C-v>": 'VB',
				\ 'c' : 'C',
				\ 's' : 'S',
				\ 'S' : 'SL',
				\ "\<C-s>": 'SB',
				\ 't': 'T',
				\ }
endfunction

function! s:PlugTmuxLine()
	Plug 'edkolev/tmuxline.vim'
endfunction

call plug#begin()
Plug 'felixhummel/setcolors.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
call s:PlugLightline()
call s:PlugTmuxLine()
Plug 'leafgarland/typescript-vim', { 'for': 'typesript' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'vim-scripts/tf2.vim', { 'for': 'tf2' }
Plug 'tbastos/vim-lua', { 'for': 'lua' }
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
call s:PlugRainbow()
"call s:PlugIndentLine()
call s:PlugAle()
"call PlugGutentags()
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"Plug 'sbdchd/neoformat'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
"call s:PlugVimspector()
call s:PlugFZF()
"call s:PlugUltiSnips()
"Plug 'honza/vim-snippets'
"Plug 'tpope/vim-classpath'
if has("nvim")
	Plug 'nvim-lua/plenary.nvim'
	Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
	Plug 'DanilaMihailov/beacon.nvim'
	Plug 'lukas-reineke/indent-blankline.nvim'
	Plug 'lukas-reineke/virt-column.nvim'
	"Plug 'Shougo/deoplete.nvim'
	Plug 'ThePrimeagen/harpoon'
	Plug 'github/copilot.vim'
endif
call plug#helptags()
call plug#end()


"}}}


" Syntax / Filetype / Colorscheme... {{{

" Colorsheme
filetype plugin indent on
syntax on
"TODO: add check on enabled gruvbox
if s:PluginIsLoaded("gruvbox")
	set background=dark
	let g:gruvbox_italic=1
	let g:gruvbox_contrast_dark='hard'
	let g:gruvbox_contrast_light='soft'
	let g:gruvbox_invert_signs=1
	colorscheme gruvbox
endif

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

" needs to be loaded last to not be overwritten by colorscheme
if s:PluginIsLoaded("beacon.nvim")
	highlight Beacon guibg=white ctermbg=15
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
" set nowrap
set updatetime=100

" Indentation
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=0
augroup indentation
	autocmd FileType html setlocal shiftwidth=2 softtabstop=2
	autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2
	autocmd FileType ocaml setlocal shiftwidth=2 softtabstop=2
augroup END

" UI
set wildmenu
"set textwidth=80
set colorcolumn=81
lua require("virt-column").setup()
set cursorline
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,eol:\|

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
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

let g:asmsyntax = 'nasm'
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

if s:PluginIsLoaded("fzf.vim")
	nnoremap <leader>f <CMD>Files<CR>
endif

if s:PluginIsLoaded("harpoon")
	nnoremap <leader>Ha <CMD>lua require("harpoon.mark").add_file()<CR>
	nnoremap <leader>Ht <CMD>lua require("harpoon.ui").toggle_quick_menu()<CR>
	nnoremap <leader><leader>h <CMD>lua require("harpoon.ui").nav_file(vim.v.count1)<CR>
endif

if s:PluginIsLoaded("ale")
	nnoremap <leader>ar <CMD>ALERename<CR>
endif

"}}}


" Backup {{{

set history=200
set noswapfile
set backup
set backupdir-=.
set undofile
set undodir-=.


" netrw {{{

let g:netrw_banner = 0
let g:netrw_keepdir = 0
"let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
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
