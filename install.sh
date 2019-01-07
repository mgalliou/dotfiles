#!/bin/bash
#FONCTIONS DEFINITION
flush_stdin()
{
	while read -t 0; do read -r;done
}

symlink_dotfile()
{
	echo -n "create $1 symlink? (y/n)"
	flush_stdin
	read CREATE
	if [ "$CREATE" = "y" ]; then
		#link
		ln -sv ~/dotfiles/$1 ~/.$1
	fi
}

#BASH SETUP
symlink_dotfile "bashrc"

#TMUX SETUP
symlink_dotfile "tmux.conf"

#VIM SETUP
echo -n "setup vim? (y/n)"
flush_stdin
read SETUPVIM
if [ "$SETUPVIM" = "y" ]; then
	echo "[VIM SETUP]"
	symlink_dotfile vimrc
	symlink_dotfile vim
	symlink_dotfile config/nvim/init.vim
	mkdir -vp ~/dotfiles/vim/backup/undo ~/dotfiles/vim/bundle
	echo "Created backup/undo and bundle directories"
fi

#XORG SETUP
symlink_dotfile "Xresources"
symlink_dotfile "xinitrc"
symlink_dotfile "xmodmap"

#I3 SETUP
flush_stdin
echo -n "setup i3? (y/n)"
read SETUPI3
if [ "$SETUPI3" = "y" ]; then
	echo "[I3 SETUP]"
	mkdir -p ~/.config/i3 ~/.config/i3status
	symlink_dotfile "config/i3/config"
	symlink_dotfile "config/i3status/config"
fi
