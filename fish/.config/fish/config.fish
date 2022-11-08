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
# Abbreviations {{{
# **************************************************************************** #

function replace_cmd
	if type -q $argv[2]
		abbr $argv[1] $argv[2]
	end
end

function enable_abbr
	replace_cmd l  exa
	replace_cmd cat bat
	replace_cmd vi  nvim
	replace_cmd vim nvim
	abbr 		v	$EDITOR

	abbr -a rm "rm -I"

	abbr -a ga   "git add"
	abbr -a gc   "git clone"
	abbr -a gcm  "git commit"
	abbr -a gcma "git commit --amend"
	abbr -a gco  "git checkout"
	abbr -a gd   "git diff"
	abbr -a gds  "git diff --staged"
	abbr -a gl   "git log"
	abbr -a gpl  "git pull"
	abbr -a gps  "git push"
	abbr -a gr   "git restore"
	abbr -a grs  "git restore --staged"
	abbr -a gs   "git status"

	abbr -a m   "make"
	abbr -a mc  "make check"
	abbr -a mc  "make clean"
	abbr -a md  "make debug"
	abbr -a mfc "make fclean"
	abbr -a mr  "make re"

	if type -q exa
		abbr -a ll  "exa -l"
		abbr -a la  "exa -la"
	end

	abbr -a t "taskell"
end


enable_abbr

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
