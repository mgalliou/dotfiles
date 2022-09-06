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
# PATH {{{
# **************************************************************************** #

function add_path_for_command
	fish_add_path -p $argv[1] $argv[2]
end

fish_add_path -Pp "$HOME/bin"
add_path_for_command "$HOME/.linuxbrew/bin" brew
add_path_for_command "$HOME/.opam/bin" opam
add_path_for_command "$HOME/.local/share/gem/ruby/3.0.0/bin" ruby

set CDPATH $HOME

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
	replace_cmd ls exa
	replace_cmd cat bat
	replace_cmd v vi
	replace_cmd v vim
	replace_cmd v nvim

	abbr -a rm "rm -I"

	abbr -a ga   "git add"
	abbr -a gc   "git clone"
	abbr -a gcm  "git commit"
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

set -U fish_color_cwd yellow
set -U fish_color_host magenta
set -U fish_color_user cyan
set -U fish_greeting ""
set -U fish_uid_symbol '$'
if test (id -u) -eq 0
	set -U fish_uid_symbol '#'
end

function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

	## Time
	# set BLINK (tput blink)
	# set NOCOLOR (tput sgr0)
	# printf (date +%H):(date +%M):\

    ## User
    # $set_color $fish_color_user
	# printf (whoami)
	# set_color normal

	## Separator
    # printf '@'

    ## Host
    # set_color $fish_color_host
    # printf (prompt_hostname)
    # set_color normal


    # PWD
	# printf ': '
	printf ' '
    set_color $fish_color_cwd
	printf (prompt_pwd)

    __terlar_git_prompt
    __fish_hg_prompt
	## echo without arg just print a newline
	# echo

	# Exit status
	if not test $last_status -eq 0
		set_color $fish_color_error
	else
		set_color normal
	end
	printf ' %c ' $fish_uid_symbol
end

# opam configuration
#source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
