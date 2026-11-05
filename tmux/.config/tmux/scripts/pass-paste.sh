#!/usr/bin/env bash
# Select a gopass/pass entry with fzf and paste its first line into the given tmux pane.
# Uses a temporary tmux buffer, deleted after pasting, without pressing Enter.

set -euo pipefail

fail() {
	tmux display-message -d 3000 "pass-paste: $1" || true
	exit 1
}

check_dependencies() {
	local cmd

	for cmd in fzf tmux; do
		command -v "$cmd" >/dev/null || fail "required command not found: $cmd"
	done
	if command -v gopass >/dev/null; then
		password_cmd=gopass
	elif command -v pass >/dev/null; then
		password_cmd=pass
	else
		fail 'required command not found: gopass or pass'
	fi
}

# Run in a subshell so cd does not change the caller's directory.
list_entries() (
	local path

	if [[ $password_cmd == gopass ]]; then
		gopass ls --flat
		return
	fi

	cd "$1" || fail 'could not open the password store'
	find -L . -type f -name '*.gpg' | while IFS= read -r path; do
		path=${path#./}
		printf '%s\n' "${path%.gpg}"
	done
)

get_password() {
	local secret

	secret=$("$password_cmd" show "$1") || fail 'could not decrypt the selected entry'
	secret=${secret%%$'\n'*}
	[[ -n $secret ]] || fail 'selected entry has an empty password'
	printf '%s' "$secret"
}

# Read from stdin to keep secrets out of process arguments and the clipboard.
# Run in a subshell to keep the cleanup trap local to this operation.
paste_password() (
	local buffer="pass-paste-$$"
	local error

	trap 'tmux delete-buffer -b "$buffer" 2>/dev/null || true' EXIT
	error=$(tmux load-buffer -b "$buffer" - 2>&1) || fail "could not load the password buffer: $error"
	error=$(tmux paste-buffer -d -b "$buffer" -t "$1" 2>&1) || fail "could not paste into pane $1: $error"
)

main() {
	local pane=${1:-}
	local store=${PASSWORD_STORE_DIR:-$HOME/.password-store}
	local entry secret password_cmd

	check_dependencies
	if [[ -z $pane ]]; then
		pane=$(tmux display-message -p '#{pane_id}') || fail 'could not determine the target pane'
	fi
	tmux list-panes -a -F '#{pane_id}' | grep -Fx -- "$pane" >/dev/null || fail "target pane does not exist: $pane"
	if [[ $password_cmd == pass ]]; then
		[[ -d $store ]] || fail "password store not found: $store"
	fi
	GPG_TTY=$(tty)
	export GPG_TTY

	# Treat cancellation or picker failure as a no-op.
	entry=$(list_entries "$store" | fzf --reverse --prompt='Password: ') || return 0
	secret=$(get_password "$entry") || return 1
	printf '%s' "$secret" | paste_password "$pane"
}

main "$@"
