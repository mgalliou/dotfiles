fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.opam/bin
fish_add_path $HOME/.local/share/gem/ruby/3.0.0/bin
fish_add_path $HOME/node_modules/.bin
fish_add_path -aP $HOME/.local/share/nvim/mason/bin/
fish_add_path -aP $HOME/.linuxbrew/bin
fish_add_path -aP /home/linuxbrew/.linuxbrew/bin

if type -q nvim
    set -x EDITOR nvim
else if type -q vim
    set -x EDITOR vim
else if type -q vi
    set -x EDITOR vi
end
abbr 		v	$EDITOR

if type -q gpg
	set -x GPG_TTY $(tty)
end

if type -q zk
	set -x ZK_NOTEBOOK_DIR $HOME/notes/zk
end
