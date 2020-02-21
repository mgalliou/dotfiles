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
		alias $argv[1] $argv[2]
	end
end

replace_cmd ls exa
replace_cmd cat bat
replace_cmd vim nvim

alias gs   "git status" 
alias gd   "git diff"   
alias gc   "git clone"  
alias gpl  "git pull"   
alias ga   "git add"    
alias gcmt "git commit"
alias gpsh "git push"   
                       
alias m   "make"       
alias mc  "make clean" 
alias mfc "make fclean"
alias mr  "make re"    
alias md  "make debug"    
alias mt  "make test"    

bind -M insert \cf forward-char
bind -M insert \cb backward-char
bind -M insert \ef forward-word
bind -M insert \eb backward-word
bind -M insert \ca beginning-of-line
bind -M insert \ce end-of-line
bind -M insert \cn history-search-forward
bind -M insert \cp history-search-backward
bind -M insert \co accept-autosuggestion
bind -M insert \ck kill-line

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
