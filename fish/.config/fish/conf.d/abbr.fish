function replace_cmd
	if type -q $argv[2]
		abbr $argv[1] $argv[2]
	end
end

replace_cmd l  exa
replace_cmd cat bat
replace_cmd vi  nvim
replace_cmd vim nvim
abbr 		v	$EDITOR

abbr -a rm "rm -I"

abbr -a ga   "git add"
abbr -a gc   "git clone"
abbr -a gcm  "git commit"
abbr -a gcma "git commit --amend"
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
