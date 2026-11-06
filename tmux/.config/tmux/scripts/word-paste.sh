#!/usr/bin/env bash
# Select a word from all tmux panes (including scrollback) and paste it.
# Uses a temporary tmux buffer, deleted after pasting, without pressing Enter.

set -euo pipefail

msg() {
	tmux display-message -d 3000 "word-paste: $1" || true
	exit 1
}

check_dependencies() {
	local cmd

	for cmd in fzf tmux awk sort grep; do
		command -v "$cmd" >/dev/null || msg "required command not found: $cmd"
	done
}

list_words() {
	local panes=$1 pane

	# Join wrapped lines and omit escape sequences. Split only on whitespace
	# so paths, URLs, and other punctuation remain usable as complete tokens.
	while IFS= read -r pane; do
		tmux capture-pane -p -J -S - -t "$pane" 2>/dev/null || true
	done <<<"$panes" | awk '{ for (i = 1; i <= NF; i++) print $i }' | sort -u
}

paste_word() (
	local buffer="word-paste-$$"
	local error

	trap 'tmux delete-buffer -b "$buffer" 2>/dev/null || true' EXIT
	error=$(tmux load-buffer -b "$buffer" - 2>&1) || msg "could not load the word buffer: $error"
	error=$(tmux paste-buffer -d -b "$buffer" -t "$1" 2>&1) || msg "could not paste into pane $1: $error"
)

main() {
	local pane=${1:-}
	local panes word

	check_dependencies
	if [[ -z $pane ]]; then
		pane=$(tmux display-message -p '#{pane_id}') || msg 'could not determine the target pane'
	fi
	panes=$(tmux list-panes -a -F '#{pane_id}') || msg 'could not list panes'
	printf '%s\n' "$panes" | grep -Fx -- "$pane" >/dev/null || msg "target pane does not exist: $pane"
	# Treat cancellation or picker failure as a no-op.
	word=$(list_words "$panes" | fzf --prompt='Word: ' --reverse --no-info --no-separator) || return 0
	[[ -n $word ]] || return 0
	printf '%s' "$word" | paste_word "$pane"
}

main "$@"
