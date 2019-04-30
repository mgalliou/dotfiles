fish_vi_key_bindings

set -U fish_color_cwd white
set -U fish_color_host brgrey
set -U fish_color_user brblue
set -U fish_greeting ""

alias ls exa
alias cat bat
alias vim nvim

function fish_mode_prompt
# NOOP - Disable vim mode indicator
end

function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

	set BLINK (tput blink)
	set NOCOLOR (tput sgr0)
	echo -n [(date +%H)$BLINK:$NOCOLOR(date +%M)]\ 

    # User
    set_color $fish_color_user
    echo -n (whoami)
    set_color normal

    echo -n '@'

    # Host
    set_color $fish_color_host
    echo -n (prompt_hostname)
    set_color normal

    echo -n ':'

    # PWD
    set_color $fish_color_cwd
    echo -n ' '(prompt_pwd)
    set_color normal

    __terlar_git_prompt
    __fish_hg_prompt
    echo

    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo -n '$ '
    set_color normal
end

