install_conf_file()
{
	echo "[$1 SETUP]"
	rm ~/.$2old
	mv ~/.$2 ~/.$2old
	ln -sv ~/dotfiles/$2 ~/.$2
}

install_conf_file "VIMRC" "vimrc"
install_conf_file "VIM" "vim"
install_conf_file "TMUX" "tmux.conf"
install_conf_file "ZSH" "zshrc"

cd ~/.vim
mkdir -p backup/undo
mkdir -p bundle
echo "Created backup and bunlde directories"
git submodule update --init

#echo "[VIM SETUP]"
#mv ~/.vimrc ~/.vimrcold
#ln -sv ~/dotfiles/vimrc ~/.vimrc
#echo "Linked .vimrc file"
#mv ~/.vim ~/.vimold
#ln -sv ~/dotfiles/vim ~/.vim
#echo "Linked .vim directory"
#echo "[ZSH SETUP]"
#mv ~/.zshrc ~/.zshrcold
#ln -sv ~/dotfiles/zshrc ~/.zshrc
#echo "[TMUX SETUP]"
#mv ~/.tmux.conf ~/.tmux.confold
#ln -sv ~/dotfiles/zshrc ~/.zshrc
