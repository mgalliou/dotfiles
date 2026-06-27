if not functions -q fundle
    curl -sfL https://git.io/fundle-install | source
end

fundle plugin danhper/fish-completion-helpers
fundle plugin gazorby/fish-abbreviation-tips
if functions -q sdkman
    fundle plugin reitzig/sdkman-for-fish
end
fundle plugin laughedelic/brew-completions

fundle init
