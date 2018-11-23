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
NOCOLOR="$(tput sgr0)"
GREY="$(tput setaf 8)"

PS1='\[${BLUE}\]\u\[${NOCOLOR}\]@\[${GREY}\]\h\[${NOCOLOR}\[: \w\n\\$ '

################################################################################
# ALIASES
################################################################################

# listing
if [ -x $(command -v exa) ]; then
	alias ls="exa"
fi
alias la="ls -la"

# git
if [ -x $(command -v git) ]; then
	alias gs="git status"
	alias ga="git add"
	alias gc="git commit"
	alias gd="git diff"
fi

# vim/nvim
if [ -x $(command -v nvim) ]; then
	alias vim="nvim"
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
export MAVEN_HOME=/Users/mgalliou/tools/maven/

################################################################################
# PATH 
################################################################################

# brew
#export PATH=$HOME/.brew/bin:$PATH

# go
#export PATH=$HOME/go/bin:$PATH

# custom binaries
#export PATH=$HOME/bin:$PATH

# custom scrips
export PATH=$PATH:~/dotfiles/scripts

# maven
export PATH=$PATH:$MAVEN_HOME/bin

# mysql
export PATH=$PATH:/usr/local/Cellar/mysql@5.6/5.6.40/bin

################################################################################
# COMPLETION 
################################################################################

# bash
#source /usr/share/git/competion/git-completion.bash

# brew
if type brew 2&>/dev/null; then
  for completion_file in $(brew --prefix)/etc/bash_completion.d/*; do
    source "$completion_file"
  done
fi

