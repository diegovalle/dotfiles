#!/bin/bash
# shellcheck source=/dev/null
#
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
if [ -x "$(command -v rbenv)" ]; then
    eval "$(rbenv init -)"
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

export PATH="$HOME/.poetry/bin:$PATH"
