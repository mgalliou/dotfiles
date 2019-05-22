#!/bin/bash

PLUGINS_PATH=~/dotfiles/vim/pack/plugins/start
mkdir -p ~/dotfiles/vim/backup/undo
mkdir -p ${PLUGINS_PATH}
cd ${PLUGINS_PATH}
pwd
git clone https://github.com/felixhummel/setcolors.vim.git
#git clone https://github.com/flazz/vim-colorschemes.git
git clone https://github.com/tpope/vim-repeat.git
git clone https://github.com/tpope/vim-surround.git
#linter
git clone https://github.com/w0rp/ale
#autocompletion
git clone https://github.com/Shougo/deoplete.nvim.git
#syntax
git clone https://github.com/leafgarland/typescript-vim.git
git clone https://github.com/cespare/vim-toml.git
git clone https://github.com/dag/vim-fish.git
#brackets
git clone https://github.com/luochen1990/rainbow
cd -
