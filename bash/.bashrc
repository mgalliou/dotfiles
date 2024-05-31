# shellcheck disable=SC2135

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PROMPT

#PS1='\u@\H \w \\$ \[$(tput sgr0)\]'
#PS1='\w \\$ \[$(tput sgr0)\]'
BLUE="$(tput setaf 4)"
BBLUE="$(tput setaf 14)"
GREY="$(tput setaf 8)"
BLINK="$(tput blink)"
NOCOLOR="$(tput sgr0)"

print_time() {
	printf "%s%s:%s%s" "$(date +%H)" "$BLINK" "$NOCOLOR" "$(date +%M)"
}

PS1='[$(print_time)] \[${BBLUE}\]\u\[${NOCOLOR}\]@\[${GREY}\]\h\[${NOCOLOR}\[: \w\n\\$ '

# ENVIRONNEMENT VARIABLES

if command -v nvim >/dev/null; then
	export EDITOR=nvim
elif command -v vim >/dev/null; then
	export EDITOR=vim
elif command -v vi >/dev/null; then
	export EDITOR=vi
fi

# ALIASES

replace_cmd() {
	if command -v "$2" >/dev/null 2>&1; then
		alias "$1"="$2"
	fi
}

replace_cmd "v" "$EDITOR"
replace_cmd "cat" "bat"

if command -v git >/dev/null 2>&1; then
	alias g="git"
	alias ga="git add"
	alias gaa="git add -A"
	alias gb="git branch"
	alias gcl="git clone"
	alias gc="git commit -v"
	alias gca="git commit --amend"
	alias gca="git commit --amend --no-edit"
	alias gco="git checkout"
	alias gcom="git checkout master"
	alias gcob="git checkout -b"
	alias gd="git diff"
	alias gds="git diff --staged"
	alias gl="git log"
	alias gpl="git pull"
	alias gps="git push"
	alias gpst="git push --tags"
	alias gf="git fetch"
	alias gfp="git fetch --prune"
	alias gr="git restore"
	alias grs="git restore --staged"
	alias grv="git revert"
	alias grvh="git revert HEAD"
	alias gm="git merge"
	alias gmc="git merge --continue"
	alias gma="git merge --abort"
	alias gmm="git merge master"
	alias grb="git rebase"
	alias grbc="git rebase --continue"
	alias grba="git rebase --abort"
	alias gs="git status"
fi

if command -v eza >/dev/null; then
	LISTER="eza"
elif command -v exa >/dev/null; then
	LISTER="exa"
else
	LISTER="ls"
fi

if [[ $LISTER == "exa" || $LISTER == "eza" ]]; then
	LISTER_BASE="$LISTER --icons --group-directories-first"
	if "$LISTER" -v | grep -q '+git'; then
		LISTER_BASE="$LISTER_BASE --git"
	fi
else
	LISTER_BASE="ls"
fi

alias ls="$LISTER_BASE"
alias l="$LISTER_BASE"
alias ll="$LISTER_BASE -l"
alias la="$LISTER_BASE -la"
