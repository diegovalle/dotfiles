# shellcheck disable=SC2148
# shellcheck disable=SC2034
# shellcheck disable=SC2029
# shellcheck disable=SC2162
# shellcheck source=/dev/null

export TERM="xterm-256color"
DEFAULT_USER=diego

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
if [ ! -d "$ZSH" ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git "$ZSH"
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    #git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi
if [ ! -d "$ZSH"/custom/plugins/zsh-autosuggestions/ ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
fi
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"

COMPLETION_WAITING_DOTS="true"

# Only show three dir levels in the prompt
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=""

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable vcs virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs command_execution_time)

POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND='black'
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND='magenta'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='222'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git virtualenv zsh-autosuggestions)

source "$ZSH"/oh-my-zsh.sh

# Who doesn't want home and end to work?
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

## If you're crazy enough to not update oh-my-zsh
#DISABLE_UPDATE_PROMPT=true

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(echo $history[$(($HISTCMD-1))] |tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

### VirtualEnv ###
# pip should only run if there is a virtualenv currently activated
# prevents accidentally installing packages without a virtualenv
#export PIP_REQUIRE_VIRTUALENV=true
# create syspip workaround
#syspip(){
#   PIP_REQUIRE_VIRTUALENV="" pip "$@"
#}
#syspip3(){
#   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
#}

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
alias grep='grep --color=auto'
alias fx='firefox --new-instance --profile $(mktemp -d)'
alias chr='google-chrome --no-default-browser-check --disable-breakpad --user-data-dir=$(mktemp -d)'
alias plz='sudo $(fc -ln -1)'
# Show Disk Use of subdirectories, sort by size
alias duss="sudo du -d 1 -h | sort -hr | egrep -v ^0"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

y() {
    youtube-dl --write-sub --sub-lang en --convert-subs srt "$@"
}

# Don' store certain commands in history
function zshaddhistory() {
    emulate -L zsh
    if ! [[ $1 =~ ^"y\ |--password".* ]] ; then
        print -sr -- "${1%%$'\n'}"
        fc -p
    else
        return 1
    fi
}



### Extra ZSH options ###
# If querying the user before executing `rm *' or `rm
# path/*', first wait ten seconds and ignore anything typed
# in that time. This avoids the problem of reflexively
# answering `yes' to the query when one didn't really mean
# it.
setopt RM_STAR_WAIT

# Commands prefaced by a space aren't saved to .zsh_history
export HISTCONTROL=ignorespace
export HISTFILESIZE=100000

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Customize to your needs...
export GOPATH=~/go
export PATH=/home/diego/apps:/home/diego/.local/bin:$GOPATH/bin:$PATH:/usr/local/go/bin:/home/diego/apps/google_appengine:/home/diego/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)" > /dev/null

# virtualenv
[ -f /usr/local/bin/virtualenvwrapper.sh ] &&
    source /usr/local/bin/virtualenvwrapper.sh

# This loads nvm
[ -s "/home/diego/.nvm/nvm.sh" ] && . "/home/diego/.nvm/nvm.sh" ||
        echo install nvm

# The next line updates PATH for the Google Cloud SDK.
[ -f /home/diego/apps/google-cloud-sdk/path.zsh.inc ] &&
    source '/home/diego/apps/google-cloud-sdk/path.zsh.inc' ||
        echo install google cloud sdk

# The next line enables shell command completion for gcloud.
[ -f /home/diego/apps/google-cloud-sdk/completion.zsh.inc ] &&
    source '/home/diego/apps/google-cloud-sdk/completion.zsh.inc' ||
        echo install shell for gcloud

function sshrc() {
    if [[ -z $1 ]]; then
        echo "Specify a host"
        return 1
    fi
    local RC_DATA
    RC_DATA=$(base64 -w 0 < "${HOME}"/.bashrc)
    ssh -t "$@" "echo \"${RC_DATA}\" | base64 --decode > /tmp/${USER}_bashrc; bash --rcfile /tmp/${USER}_bashrc; rm /tmp/${USER}_bashrc"
}

function sshtmux() {
    if [[ -z $1 ]]; then
        echo "Specify a host"
        return 1
    fi
    ssh "$@" -t "tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux"
}

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
    local NUMWORDS=10
  else
    local NUMWORDS=$1
  fi
  echo Your password has "$(echo "scale=1;$NUMWORDS * 12.9" | bc)" bits of entropy
  shuf --random-source=/dev/urandom ~/.eff_large_wordlist.txt | \
       head -n"$NUMWORDS" | \
       awk -F" " '{printf "%s.", $2} END {print ""}' | \
       sed 's/\.$//'

}

diceware_short () {
  if [[ -z $1 ]]; then
    local NUMWORDS=12
  else
    local NUMWORDS=$1
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
    printf "Usage: rproject dirname \n forgot to specify the directory name"
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
  if builtin cd "$@"; then
      echo "$OLDPWD -> $PWD"
  fi
}

# Create a symlink to the .git/hooks directory so
# that I can be able to store githooks in version control
install_hook() {
    if [[ -z $1 ]]; then
        echo Usage: install_hook hook.sh
    fi
    if GITDIR=$(git rev-parse --git-dir)/hooks ; then
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

function wipe() {
    if [[ -z "$1" ]]; then
        echo Usage: wipe file|directory
    fi
    read "REPLY?Are you sure you want to delete and wipe $*? [y/n]"
    echo ""
    if [[ "$REPLY" == "y" ]]; then
        for PASSED in "$@"
        do
            if [[ -d "$PASSED" ]]; then
                find "$PASSED" -depth -type f -exec shred -v -n 1 {} \;
                sync
                find "$PASSED" -depth -type f -exec shred -v -n 0 -z -u {} \;
            elif [[ -f $PASSED ]]; then
                shred -v -n 1 "$PASSED"
                sync
                shred -v -n 0 -z -u "$PASSED"
            else
                echo "$PASSED is not valid file or directory"
                return 1
            fi
        done
    else
        echo "You have to answer 'y' to delete"
        return 1
    fi
}
# Store ssh key passwords in ssh-agent
# ps -p $SSH_AGENT_PID > /dev/null || eval $(ssh-agent -s)
