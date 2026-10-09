# dotfiles

Personal configuration files and scripts.

## Setup

Install with GNU Stow from the repository root:

```sh
stow --no-folding -n -v -t ~ APP # Dry run
stow --no-folding -t ~ APP 
stow --no-folding -D -t ~ APP # Unlink
```

`-t ~` can be omitted if the repository is cloned under the `$HOME` directory.
