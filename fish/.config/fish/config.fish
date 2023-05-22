if not status is-interactive
    return
end

set CONFIG_PATH ~/.config/fish

source $CONFIG_PATH/fundle.fish
source $CONFIG_PATH/env.fish
source $CONFIG_PATH/fzf.fish

function update_abbr
	source $CONFIG_PATH/abbr.fish
end

if type -q starship
    starship init fish | source
else
    source $CONFIG_PATH/prompt.fish
end
