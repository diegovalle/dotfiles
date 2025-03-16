#!/bin/bash
# shellcheck source=/dev/null
#
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"


# Added by Toolbox App
export PATH="$PATH:/home/diego/.local/share/JetBrains/Toolbox/scripts"

export PATH="/home/diego/.yarn/bin:/home/diego/.config/yarn/global/node_modules/.bin:/home/diego/.nvm/versions/node/v14.7.0/bin:/home/diego/bin/bin:/home/diego/.npm-global/bin:/home/diego/.pyenv/plugins/pyenv-virtualenv/shims:/home/diego/.pyenv/shims:/home/diego/.pyenv/bin:/home/diego/.rbenv/bin:/home/diego/apps:/home/diego/.local/bin:/home/diego/go/bin:/home/diego/.poetry/bin:/home/diego/.cargo/bin:/usr/local/bin:/usr/local/sbin:/home/diego/.poetry/bin:/home/diego/.cargo/bin:/home/diego/bin:/home/diego/go/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin:/home/diego/.local/share/JetBrains/Toolbox/scripts:/home/diego/.local/share/JetBrains/Toolbox/scripts:/usr/local/go/bin:/home/diego/apps/google_appengine:/home/diego/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/diego/.vector/bin"
. "/home/diego/.deno/env"
. "$HOME/.atuin/bin/env"
