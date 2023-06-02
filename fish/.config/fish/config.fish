if not status is-interactive
    return
end

set -l CONFIG_PATH ~/.config/fish

source $CONFIG_PATH/fundle.fish
source $CONFIG_PATH/env.fish
source $CONFIG_PATH/abbr.fish
source $CONFIG_PATH/fzf.fish

if type -q zoxide
	zoxide init fish | source
end

if type -q starship
    starship init fish | source
else
    source $CONFIG_PATH/prompt.fish
end
