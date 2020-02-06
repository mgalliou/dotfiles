#!/bin/bash

main()
{
	PLUGINS_PATH=~/dotfiles/vim/pack/plugins/start
	REPOS="
	https://github.com/felixhummel/setcolors.vim
	https://github.com/morhetz/gruvbox.git
	https://github.com/tpope/vim-repeat
	https://github.com/tpope/vim-surround
	https://github.com/junegunn/fzf.vim
	https://github.com/w0rp/ale
	https://github.com/Shougo/deoplete.nvim
	https://github.com/leafgarland/typescript-vim
	https://github.com/cespare/vim-toml
	https://github.com/dag/vim-fish
	https://github.com/vim-scripts/tf2.vim.git
	https://github.com/luochen1990/rainbow
	https://github.com/tpope/vim-fugitive
	https://github.com/airblade/vim-gitgutter
	https://github.com/tbastos/vim-lua
	https://github.com/ludovicchabant/vim-gutentags.git
	"
	#https://github.com/flazz/vim-colorschemes.git

	mkdir -pv ~/dotfiles/vim/backup/undo
	mkdir -pv ${PLUGINS_PATH}
	cd ${PLUGINS_PATH} || return
	for REPO in ${REPOS}
	do
		git clone --depth 1 "$REPO"
	done
	cd - || return
}

main
