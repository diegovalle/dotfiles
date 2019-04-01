# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# added by travis gem
[ -f /home/diego/.travis/travis.sh ] && source /home/diego/.travis/travis.sh
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias mdd='mkdir $(date -I)'

# virtualenv aliases
# http://blog.doughellmann.com/2010/01/virtualenvwrapper-tips-and-tricks.html
alias v='workon'
alias v.deactivate='deactivate'
alias v.mk='mkvirtualenv --no-site-packages'
alias v.mk_withsitepackages='mkvirtualenv'
alias v.rm='rmvirtualenv'
alias v.switch='workon'
alias v.add2virtualenv='add2virtualenv'
alias v.cdsitepackages='cdsitepackages'
alias v.cd='cdvirtualenv'
alias v.lssitepackages='lssitepackages'
alias su='sudo -H -s'

alias mkdir='mkdir -pv'
# install  colordiff package :)
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias diff='colordiff'
alias ports='netstat -tulanp'
alias cd..='cd ..'
alias l='ls -laF --group-directories-first'
alias ll='ls -1aF --group-directories-first'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias pyfind='find . -name ".py"'
alias pygrep='grep --include=".py"'
alias rfind='find . -name ".R"'
alias rgrep='grep --include=".R"'
alias untar='tar -zxvf'
alias untarxz='tar -xJf'
#alias ls='ls -X -h --group-directories-first --color'
alias grep='grep --color=auto'
alias fx='firefox --new-instance --profile $(mktemp -d)'
alias chr='google-chrome --no-default-browser-check --disable-breakpad --user-data-dir=$(mktemp -d)'
alias plz='sudo $(fc -ln -1)'
# Show Disk Use of subdirectories, sort by size
alias duss="sudo du -d 1 -h | sort -hr | egrep -v ^0"

#alias ydl="youtube-dl --write-sub --sub-lang en --convert-subs srt"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


# creates a directory and cds into it
function mkcd() {
    mkdir -p "$1" && cd "$1" || exit
}

# lists zombie processes
function zombie() {
    ps aux | awk '{if ($8=="Z") { print $2 }}'
}

diceware () {
  if [[ -z $1 ]]; then
    NUMWORDS=10
  else
    NUMWORDS=$1
  fi
  echo Your password has "$(echo "scale=1;$NUMWORDS * 12.9" | bc)" bits of entropy
  shuf --random-source=/dev/urandom ~/.eff_large_wordlist.txt | \
       head -n"$NUMWORDS" | \
       awk -F" " '{printf "%s.", $2} END {print ""}' | \
       sed 's/\.$//'

}

diceware_short () {
  if [[ -z $1 ]]; then
    NUMWORDS=12
  else
    NUMWORDS=$1
  fi
  echo Your password has "$(echo "scale=1;$NUMWORDS * 10.3" | bc)" bits of entropy
  shuf --random-source=/dev/urandom ~/.eff_small_wordlist.txt | \
       head -n"$NUMWORDS" | \
       awk -F" " '{printf "%s.", $2} END {print ""}'| \
       sed 's/\.$//'

}

curlbench() {
    if [[ -z $1 ]]; then
    echo "Usage: $0 http://example.com"
  fi
    curl -w "\n    time_namelookup:  %{time_namelookup}\n       time_connect:  %{time_connect}\n    time_appconnect:  %{time_appconnect}\n   time_pretransfer:  %{time_pretransfer}\n      time_redirect:  %{time_redirect}\n time_starttransfer:  %{time_starttransfer}\n                      -----   \n         time_total:  %{time_total}\n\n" -o /dev/null -s "$1"
}

## R programming stuff

# Stop R from promping to save workspace
alias R='R --no-save --no-restore-data --quiet'

# Create an R project the way I like it
rproject() {
  if [ -z "$1" ]; then
    printf "Usage: rproject dirname \n forgot to specify the directory name\n"
    return 1
  fi
  if [ -d "$1" ]; then
    echo "directory already exists"
    return 1
  fi
  if [ -f "$1" ]; then
      echo "there's already a file with that name"
      return 1
  fi
  mkdir -p "$1/graphs"
  mkdir -p "$1/R"
  mkdir -p "$1/output"
  mkdir -p "$1/data/$(date +%Y-%m-%d)"
  mkdir -p "$1/cache"
  mkdir -p "$1/meta"
  cd "$1" || exit
  cat >> analysis.R<<EOF
## This program does

## Auto-Install packages
.packs <- c("ggplot2")
.success <- suppressWarnings(sapply(.packs, require, character.only = TRUE))
if (length(names(.success)[!.success])) {
  install.packages(names(.success)[!.success])
  sapply(names(.success)[!.success], require, character.only = TRUE)
}

options(stringsAsFactors = FALSE)

## source("R/functions.R")
EOF
  cat >> .gitignore<<EOF
# RStudio files
.Rproj.user/
# Don't store intermediate files
cache/*
EOF
  touch README.md
  {
  printf "Version: 1.0\n"
  printf "\n"
  printf "RestoreWorkspace: Default\n"
  printf "SaveWorkspace: Default\n"
  printf "AlwaysSaveHistory: Default\n"
  printf "\n"
  printf "EnableCodeIndexing: Yes\n"
  printf "UseSpacesForTab: Yes\n"
  printf "NumSpacesForTab: 2\n"
  printf "Encoding: UTF-8\n"
  printf "\n"
  printf "RnwWeave: Sweave\n"
  printf "LaTeX: pdfLaTeX\n"
  } > "$*".Rproj
  return 0
}


# To change the R package directory uncomment
#R_LIBS_SITE_USER="/home/diego/R/packages"

mkbash() {
    if [[ -z $1 ]]; then
        echo Usage: mkbash filename.sh
    fi
    if [ -d "$1" ]; then
        echo "directory already exists"
        return 1
    fi
    if [ -f "$1" ]; then
        echo "there's already a file with that name"
        return 1
    fi
    cat >> "$1" <<EOF
#!/bin/bash
set -euo pipefail #exit on error, undefined and prevent pipeline errors
IFS=$'\n\t'
EOF
}

# Show to which directory we are changing into
cd () {
  builtin cd "$@"
  echo "$OLDPWD -> $PWD"
}

# Create a symlink to the .git/hooks directory so
# that I can be able to store githooks in version control
install_hook() {
    if [[ -z $1 ]]; then
        echo Usage: install_hook hook.sh
    fi
    GITDIR=$(git rev-parse --git-dir)/hooks
    if [ ! $? -eq 0 ] ; then
        echo "Must be run inside a git repository"
        return 1
    fi
    if [ -f  "$1" ]; then
        chmod +x "$1"
        ln -s -f "$1" "$GITDIR"/"$1"
        return 0
    else
        echo "No such file"
        return 1
    fi
}

function cheat() {
    curl -A 'curl' cht.sh/"$1"
}

function extract () {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *.deb)       ar x "$1"        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

wipe() {
    if [[ -z "$1" ]]; then
        echo Usage: wipe file|directory
    fi
    read -r -p "Are you sure you want to wipe $@? [y/N] " response
    response=${response,,}    # tolower
    if [[ "$response" =~ ^(yes|y)$ ]]; then
        echo    # (optional) move to a new line
        for PASSED in "$@"
        do
            if [[ -d "$PASSED" ]]; then
                find "$PASSED" -depth -type f -exec shred -v -n 1 {} \;
                sync
                find "$PASSED" -depth -type f -exec shred -v -n 0 -z -u {} \;
            elif [[ -f $PASSED ]]; then
                shred -v -n 1 $PASSED
                sync
                shred -v -n 0 -z -u $PASSED
            else
                echo "$PASSED is not valid file or directory"
                return 1
            fi
        done
    else
        return 1
    fi

}

function nonzero_return() {
    RETVAL=$?
    [ $RETVAL -ne 0 ] && echo "$RETVAL:"
}

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo "[${BRANCH}${STAT}]"
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}


export PS1="\[\e[93;41m\]\`nonzero_return\`\[\e[m\]\[\e[m\]\h\[\e[1;30m\]:\[\e[1;34m\]\W\[\e[1;30m\]:\[\e[0;30;42m\]\`parse_git_branch\`\[\e[m\]\\$ "
#export PS1="\`nonzero_return\` "
# Store ssh key passwords in ssh-agent
# ps -p $SSH_AGENT_PID > /dev/null || eval $(ssh-agent -s)
