fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.opam/bin
if type -q ruby
    fish_add_path $HOME/.local/share/gem/ruby/$(ruby -v | awk '{print $2}')/bin
end
fish_add_path $HOME/node_modules/.bin
fish_add_path $HOME/.krew/bin
fish_add_path $HOME/go/bin
fish_add_path -a $HOME/.local/share/nvim/mason/bin/
fish_add_path -a $HOME/.linuxbrew/bin
fish_add_path -a /home/linuxbrew/.linuxbrew/bin
if type -q ruby
    fish_add_path -a /home/linuxbrew/.linuxbrew/lib/ruby/gems/$(ruby -v | awk '{print $2}')/bin
end

if type -q nvim
    set -x EDITOR nvim
    set -x MANPAGER "nvim +Man!"
else if type -q vim
    set -x EDITOR vim
    set -x MANPAGER "vim -M +MANPAGER -"
else if type -q vi
    set -x EDITOR vi
end
abbr v $EDITOR

if type -q gpg
    set -x GPG_TTY $(tty)
end

if type -q zk
    set -x ZK_NOTEBOOK_DIR $HOME/notes/zk
end
