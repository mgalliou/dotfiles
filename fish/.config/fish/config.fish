# **************************************************************************** #
# Behavior {{{
# **************************************************************************** #

#fish_vi_key_bindings

# FZF
if type -q fzf
	export FZF_DEFAULT_COMMAND="find * -type f"
	fzf_key_bindings
end

#}}},
# **************************************************************************** #
# Environment {{{
# **************************************************************************** #

fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.linuxbrew/bin
fish_add_path $HOME/.opam/bin
fish_add_path $HOME/.local/share/gem/ruby/3.0.0/bin
fish_add_path $HOME/node_modules/.bin
#set CDPATH $HOME

if type -q nvim
	set -x EDITOR nvim
else if type -q vim
	set -x EDITOR vim
else if type -q vi
	set -x EDITOR vi
end

#}}},
# **************************************************************************** #
# Keybinds {{{
# **************************************************************************** #

# left
#bind \e\[D ''
# right
#bind \e\[C ''
# up
#bind \e\[A ''
# down
#bind \e\[B ''

#}}},
# **************************************************************************** #
# Prompt {{{
# **************************************************************************** #

function fish_mode_prompt
# NOOP - Disable vim mode indicator
end

source $HOME/.config/fish/custom_prompt.fish

# opam configuration
#source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
