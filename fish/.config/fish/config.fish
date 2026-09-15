if not status is-interactive
    return
end

set -g fish_greeting
set -g fish_cursor_default block

set -l CONFIG_PATH ~/.config/fish

source "$CONFIG_PATH/fundle.fish"
source "$CONFIG_PATH/env.fish"
source "$CONFIG_PATH/abbr.fish"

if type -q zoxide
    zoxide init fish | source
end

if type -q starship
    starship init fish | source
else
    source "$CONFIG_PATH/prompt.fish"
end

function delete_last_history_entry
    history delete --exact --case-sensitive (history --max 1)
end
