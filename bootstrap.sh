#!/bin/bash
set -x
# Install Diego Valle's dotfiles
# https://github.com/diegovalle/dotfiles

git clone --recurse-submodules --bare \
    https://github.com/diegovalle/dotfiles.git "$HOME"/.dotfiles
dotfiles() {
   git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" "$@"
}

# Need to chekout emacs submodule
if checkout && cd .emacs.d && \
        dotfiles submodule update --init --recursive;
  then
    echo "Cloned dotfiles"
  else
    echo "Backing up pre-existing dot files.";
    mkdir -p .dotfiles-backup
    echo "Backing up pre-existeing files to .dotfiles-backup"
    dotfiles checkout 2>&1 | grep -E "^\s+" | awk '{print $1}' | \
             xargs -I{} mv {} .dotfiles-backup/{}
    dotfiles checkout
    ( cd .emacs.d && dotfiles submodule update --init --recursive )
fi;

dotfiles config status.showUntrackedFiles no
