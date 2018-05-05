#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#prompt
PS1='\u@\H \w \\$ \[$(tput sgr0)\]'


#aliases
alias ls='ls --color=auto'
alias gccf="gcc -Wall -Wextra -Werror"
alias newmakefile="cp ~/dotfile/Makefile ./"
alias checker="sh ~/Applications/42FileChecker/42FileChecker.sh"

#export USER="mgalliou"
#export MAIL="$USER@student.42.fr"

#PATH
#export PATH=$HOME/.brew/bin:$PATH
#export PATH=$HOME/go/bin:$PATH
#export PATH=$HOME/bin:$PATH
