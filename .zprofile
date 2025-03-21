#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='nano'
export VISUAL='nano'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"


# Added by Toolbox App
export PATH="$PATH:/home/diego/.local/share/JetBrains/Toolbox/scripts"

export PATH="/home/diego/.yarn/bin:/home/diego/.config/yarn/global/node_modules/.bin:/home/diego/.nvm/versions/node/v14.7.0/bin:/home/diego/bin/bin:/home/diego/.npm-global/bin:/home/diego/.pyenv/plugins/pyenv-virtualenv/shims:/home/diego/.pyenv/shims:/home/diego/.pyenv/bin:/home/diego/.rbenv/bin:/home/diego/apps:/home/diego/.local/bin:/home/diego/go/bin:/home/diego/.poetry/bin:/home/diego/.cargo/bin:/usr/local/bin:/usr/local/sbin:/home/diego/.poetry/bin:/home/diego/.cargo/bin:/home/diego/bin:/home/diego/go/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin:/home/diego/.local/share/JetBrains/Toolbox/scripts:/home/diego/.local/share/JetBrains/Toolbox/scripts:/usr/local/go/bin:/home/diego/apps/google_appengine:/home/diego/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/diego/.vector/bin"
