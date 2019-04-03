# Dotfiles for diegovalle

## Requirements

- Git
- Curl
- Wget
- Emacs
- Oh-my-zsh
- Powerline9k

Based on creating a bare git repo as described in: [https://news.ycombinator.com/item?id=18896422](https://news.ycombinator.com/item?id=18896422)

## Install

by running:

```bash
#!/bin/bash

# Install Diego Valle's dotfiles
# https://github.com/diegovalle/dotfiles

git clone --recurse-submodules --bare \
    https://github.com/diegovalle/dotfiles.git "$HOME"/.dotfiles
dotfiles() {
   git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" "$@"
}

# Need to chekout emacs submodule
if dotfiles checkout && cd .emacs.d && \
        dotfiles submodule update --init --recursive;
  then
    echo "Cloned dotfiles"
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
