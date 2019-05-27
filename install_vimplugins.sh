#!/bin/bash

PLUGINS_PATH=~/dotfiles/vim/pack/plugins/start
mkdir -pv ~/dotfiles/vim/backup/undo
mkdir -pv ${PLUGINS_PATH}
cd ${PLUGINS_PATH}
repos=(
	#coloschems
	https://github.com/felixhummel/setcolors.vim
	https://github.com/morhetz/gruvbox.git
	#"https://github.com/flazz/vim-colorschemes.git"
	#feature
	https://github.com/tpope/vim-repeat
	https://github.com/tpope/vim-surround
	#linter
	https://github.com/w0rp/ale
	#autocompletion
	https://github.com/Shougo/deoplete.nvim
	#syntax
	https://github.com/leafgarland/typescript-vim
	https://github.com/cespare/vim-toml
	https://github.com/dag/vim-fish
	https://github.com/vim-scripts/tf2.vim.git
	#brackets
	https://github.com/luochen1990/rainbow
	#git integration
	https://github.com/tpope/vim-fugitive
	https://github.com/airblade/vim-gitgutter
	)
for repo in "${repos[@]}"
do
	git clone $repo
done
cd -
