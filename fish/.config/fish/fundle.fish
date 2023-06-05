if not functions -q fundle
    eval (curl -sfL https://git.io/fundle-install)
end

fundle plugin danhper/fish-completion-helpers
fundle plugin gazorby/fish-abbreviation-tips
fundle plugin reitzig/sdkman-for-fish
fundle plugin laughedelic/brew-completions

fundle init
