function replace_cmd
    type -q $argv[2]; and abbr -a $argv[1] $argv[2]
end

replace_cmd cat bat
replace_cmd vi nvim
replace_cmd vim nvim
abbr v $EDITOR

abbr -a rm "rm -I"

if type -q git
    abbr -a g git
    abbr -a ga "git add"
    abbr -a gaa "git add -A"
    abbr -a gb "git branch"
    abbr -a gcl "git clone"
    abbr -a gc "git commit -v"
    abbr --set-cursor gcm "git commit -m\"%\""
    abbr -a gca "git commit -v --amend"
    abbr -a gcan "git commit --amend --no-edit"
    abbr -a gco "git checkout"
    abbr -a gcom "git checkout master"
    abbr -a gcob "git checkout -b"
    abbr -a gd "git diff"
    abbr -a gds "git diff --staged"
    abbr -a gl "git log"
    abbr -a gpl "git pull"
    abbr -a gps "git push"
    abbr -a gpst "git push --tags"
    abbr -a gf "git fetch"
    abbr -a gfp "git fetch --prune"
    abbr -a gr "git restore"
    abbr -a grs "git restore --staged"
    abbr -a grv "git revert"
    abbr -a grvh "git revert HEAD"
    abbr -a gm "git merge"
    abbr -a gmc "git merge --continue"
    abbr -a gma "git merge --abort"
    abbr -a gmm "git merge master"
    abbr -a grb "git rebase"
    abbr -a grbc "git rebase --continue"
    abbr -a grba "git rebase --abort"
    abbr -a grmt "git remote -v"
    abbr -a gs "git status"
end

if type -q make
    abbr -a m make
    abbr -a mck "make check"
    abbr -a mc "make clean"
    abbr -a md "make debug"
    abbr -a mfc "make fclean"
    abbr -a mr "make re"
end

if type -q kubectl
    abbr -a k kubectl
    abbr -a ka "kubectl apply"
    abbr -a kc "kubectl config"
    abbr -a kgx "kubectl config get-contexts"
    abbr -a ksx "kubectl config set-context"
end

if type -q helm
    abbr -a h helm
    abbr -a hl "helm list"
    abbr -a hi "helm install"
    abbr -a hup "helm upgrade --install"
    abbr -a hu "helm uninstall"
    abbr -a hps "helm push"
    abbr -a hpl "helm pull"
    abbr -a hsr "helm search repo"
    abbr -a hsh "helm search hub"
end

if type -q helmfile
    abbr -a hf helmfile
    abbr -a hfl "helmfile list"
    abbr -a hft "helmfile template"
    abbr -a hfa "helmfile apply"
    abbr -a hfd "helmfile destroy"
    abbr -a hfcc "helmfile cache cleanup"
end

if type -q npm
    abbr -a ni "npm install"
    abbr -a nb "npm run build"
    abbr -a ns "npm run start"
end

if type -q pmbootstrap
    abbr -a pmb pmbootstrap
    abbr -a pmbb "pmbootstrap build"
    abbr -a pmbl "pmbootstrap log"
    abbr -a pmbz "pmbootstrap zap"
    abbr -a pmbi "pmbootstrap install"
end

set -l LISTER ls
type -q exa; and set LISTER exa
type -q eza; and set LISTER eza

set -l LISTER_CMD "$LISTER --group-directories-first"
if type -q eza; or type -q exa
    "$LISTER" -v | string match -q '+git'; and set LISTER_CMD "$LISTER_CMD --git"
else
    set LISTER_CMD "$LISTER_CMD --color=auto"
end

abbr -a ls "$LISTER_CMD"
abbr -a l "$LISTER_CMD"
abbr -a ll "$LISTER_CMD -l"
abbr -a la "$LISTER_CMD -la"

type -q taskell; and abbr -a t taskell
