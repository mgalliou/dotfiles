#fish_vi_key_bindings

function fish_mode_prompt
# NOOP - Disable vim mode indicator
end

set -U fish_color_cwd white
set -U fish_color_host brgrey
set -U fish_color_user brblue
set -U fish_greeting ""

function replace_cmd
	if type -q $argv[2]
		abbr $argv[1] $argv[2]
	end
end

replace_cmd ls exa
replace_cmd cat bat
replace_cmd vim nvim

abbr -a gs   "git status" 
abbr -a gd   "git diff"   
abbr -a gc   "git clone"  
abbr -a gpl  "git pull"   
abbr -a ga   "git add"    
abbr -a gcmt "git commit"
abbr -a gpsh "git push"   

abbr -a m   "make"       
abbr -a mc  "make clean" 
abbr -a mfc "make fclean"
abbr -a mr  "make re"    
abbr -a md  "make debug"    
abbr -a mc  "make check"    

# left
bind \e\[D ''
# right
bind \e\[C ''
# up
bind \e\[A ''
# down
bind \e\[B ''

function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

	set BLINK (tput blink)
	set NOCOLOR (tput sgr0)
	printf [(date +%H)$BLINK:$NOCOLOR(date +%M)]\ 

    # User
    set_color $fish_color_user
    printf (whoami)
    set_color normal

    printf '@'

    # Host
    set_color $fish_color_host
    printf (prompt_hostname)
    set_color normal

    printf ':'

    # PWD
    set_color $fish_color_cwd
    printf ' '(prompt_pwd)
    set_color normal

    __terlar_git_prompt
    __fish_hg_prompt
    echo

    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    printf '$ '
    set_color normal
end

if [ (uname -o) = "Android" ]
	source $HOME/dotfiles/config/fish/completions/pass.fish
end
