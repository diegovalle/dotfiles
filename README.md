# Dotfiles for diegovalle

[![Build Status](https://travis-ci.org/diegovalle/dotfiles.svg?branch=master)](https://travis-ci.org/diegovalle/dotfiles)

## Requirements

- Git
- Vim
- Curl
- Wget
- Emacs
- Oh-my-zsh
- Powerline9k
- tmux
- bash

Based on creating a bare git repo as described in: [https://news.ycombinator.com/item?id=18896422](https://news.ycombinator.com/item?id=18896422)

## Install

by running ```bootstrap``` or ```bash <(curl -fsSL https://diegovalle.net/dotfiles)```

```bash
#!/bin/bash
set -euo pipefail

# Install Diego Valle's dotfiles
# https://github.com/diegovalle/dotfiles

git clone --recurse-submodules --bare \
    https://github.com/diegovalle/dotfiles.git "$HOME"/.dotfiles
dotfiles() {
   git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" "$@"
}

# Need to chekout emacs submodule
if dotfiles checkout && ( cd .emacs.d && \
        dotfiles submodule update --init --recursive );
  then
    echo "Cloned dotfiles"
  else
    echo "Backing up pre-existeing files to ~/.dotfiles-backup"
    mkdir -p "$HOME"/.dotfiles-backup
    (dotfiles checkout 2>&1 || true) | grep -E "^\s+" | awk '{print $1}' | \
        xargs -I{} mv "$HOME"/{} "$HOME"/.dotfiles-backup/{}
    if [ -d "$HOME"/.emacs.d ]; then
        mv -R "$HOME"/.emacs.d "$HOME"/.dotfiles-backup
    fi
    dotfiles checkout
    ( cd .emacs.d && dotfiles submodule update --init --recursive )
fi;

dotfiles config status.showUntrackedFiles no
```

.dotfiles == directory to store the git database

dotfiles == git alias
