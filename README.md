# Dotfiles for diegovalle

## Requirements

- Git
- Curl
- Wget
- Emacs
- Oh-my-zsh
- Powerline9k


## Install

Install config tracking in your $HOME by running:

```bashsh
#!/bin/bash

git clone --recurse-submodules --bare \
    https://github.com/diegovalle/dotfiles.git "$HOME"/.dotfiles
dotfiles() {
   git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" "$@"
}

if dotfiles checkout; then
    echo "Cloned dotfiles"
    # Need to chekout emacs submodule
    ( cd .emacs.d && dotfiles submodule update --init --recursive )
  else
    echo "Backing up pre-existing dot files.";
    mkdir -p .dotfiles-backup
    dotfiles checkout 2>&1 | grep -E "^\s+" | awk '{print $1}' | \
             xargs -I{} mv {} .dotfiles-backup/{}
    dotfiles checkout
    ( cd .emacs.d && dotfiles submodule update --init --recursive )
fi;

dotfiles config status.showUntrackedFiles no
```

.dotfiles == directory to store the git database
dotfiles == git alias
