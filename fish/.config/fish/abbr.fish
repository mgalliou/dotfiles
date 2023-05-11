function replace_cmd
	if type -q $argv[2]
		abbr -a $argv[1] $argv[2]
	end
end

replace_cmd cat bat
replace_cmd vi  nvim
replace_cmd vim nvim
abbr 		v	$EDITOR

abbr -a rm "rm -I"

if type -q git
	abbr -a g    "git"
	abbr -a ga   "git add"
	abbr -a gaa  "git add -A"
	abbr -a gcl  "git clone"
	abbr -a gc   "git commit -v"
	abbr --set-cursor gcm "git commit -m\"%\""
	abbr -a gca  "git commit --amend"
	abbr -a gcan "git commit --amend --no-edit"
	abbr -a gco  "git checkout"
	abbr -a gd   "git diff"
	abbr -a gds  "git diff --staged"
	abbr -a gl   "git log"
	abbr -a gpl  "git pull"
	abbr -a gps  "git push"
	abbr -a gr   "git restore"
	abbr -a grs  "git restore --staged"
	abbr -a gs   "git status"
end

if type -q make
   abbr -a m   "make"
	abbr -a mc  "make check"
	abbr -a mc  "make clean"
	abbr -a md  "make debug"
	abbr -a mfc "make fclean"
	abbr -a mr  "make re"
end

#TODO: add more abbrs
if type -q kubectl
	abbr -a k   "kubectl"
	abbr -a ka  "kubectl apply"
	abbr -a kc  "kubectl config"
	abbr -a kgx "kubectl config get-contexts"
	abbr -a ksx "kubectl config set-context"
end

if type -q helm
	abbr -a h   "helm"
	abbr -a hl  "helm list"
	abbr -a hi  "helm install"
	abbr -a hup "helm upgrade --install"
	abbr -a hu  "helm uninstall"
end

if type -q exa
	set -l EXA_BASE "exa --icons --group-directories-first"
	if exa -v | grep -q '+git'
		set EXA_BASE "$EXA_BASE --git"
	end
	abbr -a ls  "$EXA_BASE"
	abbr -a l   "$EXA_BASE"
	abbr -a ll  "$EXA_BASE -l"
	abbr -a la  "$EXA_BASE -la"
end

if type -q taskell
	abbr -a t "taskell"
end
