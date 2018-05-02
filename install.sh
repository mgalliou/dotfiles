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
		#create a backup
		#link
		ln -sv ~/dotfiles/$1 ~/.$1
	fi
}

#VIM SETUP
echo -n "setup vim? (y/n)"
flush_stdin
read SETUPVIM
if [ "$SETUPVIM" = "y" ]; then
	echo "[VIM SETUP]"
	symlink_dotfile vimrc
	symlink_dotfile vim
	mkdir -p ~/dotfiles/backup/undo ~/dotfiles/bundle
	echo "Created backup/undo and bundle directories"
fi

#TMUX SETUP
symlink_dotfile "tmux.conf"

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
	symlink_dotfile "config/i3"
	symlink_dotfile "config/i3status"
fi
