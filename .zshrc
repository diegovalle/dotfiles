export TERM="xterm-256color"
DEFAULT_USER=diego

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"

COMPLETION_WAITING_DOTS="true"

# Only show two dir levels in the prompt
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=""

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable vcs )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status  command_execution_time)

POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND='black'
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND='magenta'

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git virtualenv)

source "$ZSH"/oh-my-zsh.sh

# Who doesn't want home and end to work?
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

## If you're crazy enough to not update oh-my-zsh
#DISABLE_UPDATE_PROMPT=true

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
alias cd..=cd ..
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

#alias ydl="youtube-dl --write-sub --sub-lang en --convert-subs srt"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

y() {
    youtube-dl --write-sub --sub-lang en --convert-subs srt "$1"
    history -d $((HISTCMD-1))
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
export PATH=/home/diego/apps:/home/diego/.local/bin:$GOPATH/bin:$PATH:/usr/local/go/bin:/home/diego/apps/google_appengine:/home/diego/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/diego/apps/openshift-origin-client-tools
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# virtualenv
[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

# This loads nvm
[ -s "/home/diego/.nvm/nvm.sh" ] && . "/home/diego/.nvm/nvm.sh" || echo install nvm

# The next line updates PATH for the Google Cloud SDK.
[ -f /home/diego/apps/google-cloud-sdk/path.zsh.inc ] && source '/home/diego/apps/google-cloud-sdk/path.zsh.inc' || echo install google cloud sdk

# The next line enables shell command completion for gcloud.
[ -f /home/diego/apps/google-cloud-sdk/completion.zsh.inc ] && source '/home/diego/apps/google-cloud-sdk/completion.zsh.inc' || echo install shell for gcloud

# added by travis gem
[ -f /home/diego/.travis/travis.sh ] && source /home/diego/.travis/travis.sh || echo install travis autocomplete


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
  curl -w "@$HOME/.curl-format" -o /dev/null -s "$1"
}

## R programming stuff

# Stop R from promping to save workspace
alias R='R --no-save --no-restore-data --quiet'

# Create an R project the way I like it
rproject() {
  if [ -z "$1" ]; then
    printf "Usage: rproject dirname \n forgot to specify the directory name"
    return 0
  fi
  if [ -d "$1" ]; then
    echo "directory already exists"
    return 0
  fi
  if [ -f "$1" ]; then
      echo "there's already a file with that name"
      return 0
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

## Install packages
.packs <- c("ggplot2")
.success <- suppressWarnings(sapply(.packs, require, character.only = TRUE))
if (length(names(.success)[!.success])) {
  install.packages(names(.success)[!.success])
  sapply(names(success)[!.success], require, character.only = TRUE)
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
        return 0
    fi
    if [ -f "$1" ]; then
        echo "there's already a file with that name"
        return 0
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

# Store ssh key passwords in ssh-agent
# ps -p $SSH_AGENT_PID > /dev/null || eval $(ssh-agent -s)
