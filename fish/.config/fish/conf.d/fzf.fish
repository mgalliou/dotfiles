if type -q fzf
    export FZF_DEFAULT_COMMAND="find * -type f"
    fzf_key_bindings
end
