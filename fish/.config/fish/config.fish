if status is-interactive
	set -l CONFIG_PATH ~/.config/fish

	source $CONFIG_PATH/env.fish
	source $CONFIG_PATH/prompt.fish
	source $CONFIG_PATH/abbr.fish
	source $CONFIG_PATH/fzf.fish
	source $CONFIG_PATH/bobthefish.fish
end
