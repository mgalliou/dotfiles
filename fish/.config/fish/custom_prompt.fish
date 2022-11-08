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
