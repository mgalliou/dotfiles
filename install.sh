#!/bin/sh

flush_stdin()
{
	echo | read -r
}

symlink_dotfile()
{
	printf "create %s symlink? (y/n) " "$1"
	flush_stdin
	read -r CREATE
	if [ "$CREATE" = "y" ]; then
		mkdir -pv ~/."$(dirname "$1")"
		ln -sv ~/dotfiles/"$1" ~/."$1"
	fi
}

main ()
{
	symlink_dotfile "bashrc"
	symlink_dotfile "config/fish/config.fish"
	symlink_dotfile "tmux.conf"

	printf "setup vim? (y/n) "
	flush_stdin
	read -r SETUPVIM
	if [ "$SETUPVIM" = "y" ]; then
		echo "[VIM SETUP]"
		symlink_dotfile vimrc
		symlink_dotfile vim
		symlink_dotfile config/nvim/init.vim
		mkdir -pv ~/dotfiles/vim/backup/undo ~/dotfiles/vim/bundle
		echo "Created backup/undo and bundle directories"
	fi

	symlink_dotfile "config/taskell"
	symlink_dotfile "Xresources"
	symlink_dotfile "xinitrc"
	symlink_dotfile "xmodmap"
	symlink_dotfile "config/termite/config"

	printf "setup i3? (y/n) "
	flush_stdin
	read -r SETUPI3
	if [ "$SETUPI3" = "y" ]; then
		echo "[I3 SETUP]"
		mkdir -pv ~/.config/i3 ~/.config/i3status
		symlink_dotfile "config/i3/config"
		symlink_dotfile "config/i3status/config"
	fi
}

main
