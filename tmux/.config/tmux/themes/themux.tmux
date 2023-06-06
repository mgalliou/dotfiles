#!/usr/bin/env bash

BLACK="#282828"
BBLACK="#3c3836"
WHITE="#ebdbb2"
GRAY="#928374"
WHITE="#ebdbb2"
RED="#fb4934"
GREEN="#b8bb26"
YELLOW="#fabd2f"
BLUE="#83a598"
MAGENTA="#d3869b"
CYAN="#8ec07c"
ORANGE="#fe8019"

FG="$WHITE"
BG="$BLACK"
BG1="$BBLACK"
BG2="#504945"
BG3="#665c54"
BG4="#7c6f64"

LS=""
RS=""

RESET="nobold,nounderscore,noitalics"

get_tmux_option() {
	local option value default
	option="$1"
	default="$2"
	value="$(tmux show-option -gqv "$option")"

	if [ -n "$value" ]; then
		echo "$value"
	else
		echo "$default"
	fi
}

set() {
	local option=$1
	local value=$2
	tmux_commands+=(set-option -gq "$option" "$value" ";")
}

setw() {
	local option=$1
	local value=$2
	tmux_commands+=(set-window-option -gq "$option" "$value" ";")
}

session() {
	local indicator
	local indicator_style
	local style
	local session

	readonly indicator="  "
	readonly indicator_style="#[fg=$BG,bg=$GREEN,bold]"
	readonly style="#[fg=$FG,bg=$BG2]"
  	readonly session=" #S "
	echo "${indicator_style}${indicator}${style}${session}#[default]"
}

user() {
	local indicator
	local indicator_style
	local style
	local user

	readonly indicator="  "
	readonly indicator_style="#[fg=$BG,bg=$YELLOW]"
	readonly style="#[fg=$FG,bg=$BG2]"
	readonly user=" #{USER} "
	echo "${indicator_style}${indicator}${style}${user}"
}

host() {
	local indicator
	local indicator_style
	local style
	local host

	readonly indicator=" 󰒋 "
	readonly indicator_style="#[fg=$BG,bg=$RED]"
	readonly style="#[fg=$FG,bg=$BG2]"
	readonly host=" #H "
	echo "${indicator_style}${indicator}${style}${host}"
}

date_time() {
	local indicator
	local indicator_style
	local style
	local date_time

	readonly indicator="  "
	readonly indicator_style="#[fg=$BG,bg=$BLUE]"
	readonly style="#[fg=$FG,bg=$BG2]"
	readonly date_time=" %R "
	echo "${indicator_style}${indicator}${style}${date_time}"
}

status_left() {
	echo "$(session)"
}

status_right() {
	echo "$(user)$(host)$(date_time)"
}

window_status_format() {
	local index_style="#[fg=$BG,bg=$BLUE,$RESET]"
	local name_style="#[fg=$BG4,bg=$BG1,$RESET]"
	local index="$index_style #I "
	local name="$name_style #W#F "

	echo "$index$name"
}

window_status_current_format() {
	local index_style="#[fg=$BG,bg=$ORANGE,$RESET]"
	local name_style="#[fg=$FG,bg=$BG2]"
	local index="$index_style #I "
	local name="$name_style #W#F "

	echo "$index$name"
}

main() {
	local tmux_commands=()

	set status "on"
	set status-justify "left"
	set status-style "none,bg=$BG"
	set status-left-style "none"
	set status-right-style "none"
	set status-left-length "100"
	set status-right-length "100"
	set status-left "$(status_left)"
	set status-right "$(status_right)"

	setw window-status-style "none,fg=$BG4,bg=$BG"
	setw window-status-activity-style "none,fg=$FG,bg=$BG"
	setw window-status-separator " "
	setw window-status-format "$(window_status_format)"
	setw window-status-current-format "$(window_status_current_format)"
	set message-style "fg=$FG,bg=$BG2"
	set message-command-style "fg=$FG,bg=$BG"

	set pane-border-style "fg=$BG4"
	set pane-active-border-style "fg=$BLUE"

	setw clock-mode-colour "$BLUE"
	setw mode-style "fg=$BG bg=$FG bold"

	tmux "${tmux_commands[@]}"
}

main "$@"
