if status is-interactive
	set -l CONFIG_PATH ~/.config/fish

	source $CONFIG_PATH/fundle.fish
	source $CONFIG_PATH/env.fish
	source $CONFIG_PATH/abbr.fish
	source $CONFIG_PATH/fzf.fish

	if type -q starship
		starship init fish | source
	else
		source $CONFIG_PATH/prompt.fish
	end
end

