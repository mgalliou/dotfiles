#!/bin/bash

mkdir -p ~/dotfiles/vim/backup/undo
mkdir -p ~/dotfiles/vim/bundle
cd ~/dotfiles/vim/bundle
git clone https://github.com/tpope/vim-pathogen.git
git clone https://github.com/felixhummel/setcolors.vim.git
git clone https://github.com/flazz/vim-colorschemes.git
git clone https://github.com/tpope/vim-repeat.git
git clone https://github.com/tpope/vim-surround.git
#linter
git clone https://github.com/w0rp/ale
#autocompletion
git clone https://github.com/Shougo/deoplete.nvim.git
#syntax
git clone https://github.com/leafgarland/typescript-vim.git
git clone https://github.com/cespare/vim-toml.git
#brackets
git clone https://github.com/luochen1990/rainbow
cd -
