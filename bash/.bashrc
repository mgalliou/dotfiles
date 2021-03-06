#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

################################################################################
# PROMPT
################################################################################

#PS1='\u@\H \w \\$ \[$(tput sgr0)\]'
#PS1='\w \\$ \[$(tput sgr0)\]'
BLUE="$(tput setaf 4)"
BBLUE="$(tput setaf 14)"
GREY="$(tput setaf 8)"
BLINK="$(tput blink)"
NOCOLOR="$(tput sgr0)"

print_time()
{
	printf "%s%s:%s%s" "$(date +%H)" "${BLINK}" "${NOCOLOR}" "$(date +%M)"
}

PS1='[$(print_time)] \[${BBLUE}\]\u\[${NOCOLOR}\]@\[${GREY}\]\h\[${NOCOLOR}\[: \w\n\\$ '

################################################################################
# ALIASES
################################################################################

replace_cmd()
{
	if command -v "$2" >/dev/null 2>&1; then
		alias "$1"="$2"
	fi
}

replace_cmd "ls" "exa"
replace_cmd "vim" "nvim"
replace_cmd "cat" "bat"

# listing
alias la="ls -la"

# git
if command -v git >/dev/null 2>&1; then
	alias gs="git status"
	alias ga="git add"
	alias gc="git commit"
	alias gd="git diff"
fi

alias gccf="gcc -Wall -Wextra -Werror"
alias newmakefile="cp ~/dotfile/Makefile ./"
alias checker="sh ~/Applications/42FileChecker/42FileChecker.sh"

################################################################################
# ENVIRONNEMENT VARIABLES 
################################################################################

#export USER="mgalliou"
#export MAIL="$USER@student.42.fr"

#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_171.jdk/Contents/Home/
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-10.0.1.jdk/Contents/Home
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
#export MAVEN_HOME=/Users/mgalliou/tools/maven/
#export PYTHON_HOME=

################################################################################
# PATH 
################################################################################

# brew
#export PATH=$HOME/.brew/bin:$PATH

# go
#export PATH=$HOME/go/bin:$PATH

# custom binaries
#export PATH=$HOME/bin:$PATH

# maven
#export PATH=$MAVEN_HOME/bin:$PATH

# mysql
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# custom scrips
export PATH=$PATH:~/dotfiles/scripts

# cargo
#export PATH="$HOME/.cargo/bin:$PATH"

################################################################################
# COMPLETION 
################################################################################

# bash
#source /usr/share/git/competion/git-completion.bash

# brew
#for completion_file in $(brew --prefix)/etc/bash_completion.d/* ; do
#	source $completion_file
#done

