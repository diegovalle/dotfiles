# shellcheck disable=SC2034,SC1091,SC2029,SC2162
# shellcheck source=/dev/null
# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/diego/.zsh/completions:"* ]]; then export FPATH="/home/diego/.zsh/completions:$FPATH"; fi

export TERM="xterm-256color"
export DEFAULT_USER="$USER"
export TZ=:/etc/localtime

# No telemetry
export GATSBY_TELEMETRY_DISABLED=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DO_NOT_TRACK=1
export GOTELEMETRY=off
export AZURE_CORE_COLLECT_TELEMETRY=0
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export STNOUPGRADE=1
export HOMEBREW_NO_ANALYTICS=1
export SAM_CLI_TELEMETRY=0
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward


# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
# if [ ! -d "$ZSH" ]; then
#     git clone git://github.com/robbyrussell/oh-my-zsh.git "$ZSH"
#     #git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
#     git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
# fi
# if [ ! -d "$ZSH"/custom/plugins/zsh-autosuggestions/ ]; then
#     git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
# fi
# if [ ! -d "$ZSH"/custom/plugins/zsh-histdb ]; then
#     git clone https://github.com/larkery/zsh-histdb "$ZSH"/custom/plugins/zsh-histdb
# fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
# shellcheck disable=SC2154,SC2296
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel10k/powerlevel10k"

COMPLETION_WAITING_DOTS="true"

# Only show three dir levels in the prompt
POWERLEVEL10K_SHORTEN_DIR_LENGTH=3
POWERLEVEL10K_PROMPT_ON_NEWLINE=true
POWERLEVEL10K_PROMPT_ADD_NEWLINE=true
POWERLEVEL10K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL10K_MULTILINE_LAST_PROMPT_PREFIX=""

POWERLEVEL10K_LEFT_PROMPT_ELEMENTS=(dir dir_writable vcs virtualenv)
POWERLEVEL10K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs command_execution_time)

POWERLEVEL10K_DIR_WRITABLE_FORBIDDEN_FOREGROUND='black'
POWERLEVEL10K_DIR_WRITABLE_FORBIDDEN_BACKGROUND='magenta'
POWERLEVEL10K_COMMAND_EXECUTION_TIME_BACKGROUND='222'
POWERLEVEL10K_COMMAND_EXECUTION_TIME_FOREGROUND='black'

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

plugins=(virtualenv zsh-autosuggestions zsh-syntax-highlighting direnv)

source "$ZSH"/oh-my-zsh.sh
#source "$ZSH"/custom/plugins/zsh-histdb/sqlite-history.zsh
autoload -Uz add-zsh-hook

### Extra ZSH options ###
# If querying the user before executing `rm *' or `rm
# path/*', first wait ten seconds and ignore anything typed
# in that time. This avoids the problem of reflexively
# answering `yes' to the query when one didn't really mean
# it.
setopt RM_STAR_WAIT

# Commands prefaced by a space aren't saved to .zsh_history
export HISTCONTROL=ignorespace
export HISTFILESIZE=1000000
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
#export HIST_STAMPS="yyyy-mm-dd"
setopt EXTENDED_HISTORY

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

# Who doesn't want home and end to work?
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

## If you're crazy enough to not update oh-my-zsh
#DISABLE_UPDATE_PROMPT=true

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(echo $(fc -ln -1) |tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
export PIP_REQUIRE_VIRTUALENV=true
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
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias diff='colordiff'
alias ports='netstat -tulanp'
alias cd..='cd ..'
alias l='ls -laF --human-readable --group-directories-first'
alias ll='ls -1aF --human-readable --group-directories-first'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias pyfind='find . -name ".py"'
alias pygrep='grep --include=".py"  --exclude-dir=".git"'
alias rfind='find . -name ".R"'
alias rgrep='grep --include=".R  --exclude-dir=".git""'
alias untar='tar -zxvf'
alias untarxz='tar -xJf'
alias grep='grep --color=auto'
alias fx='firefox --new-instance --profile $(mktemp -d)'
alias chr='google-chrome --no-first-run --no-default-browser-check --disable-breakpad --user-data-dir=$(mktemp -d)'
alias chrncors='google-chrome  --disable-web-security --no-first-run --no-default-browser-check --disable-breakpad --user-data-dir=$(mktemp -d)'
alias plz='sudo $(fc -ln -1)'
# Show Disk Use of subdirectories, sort by size
alias duss='du -d 1 -h | sort -hr | egrep -v ^0'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias npm='aa-exec -p node_sandbox -- npm'
alias gatsby='aa-exec -p node_sandbox -- gatsby'
# ----------------------
# Git Aliases
# ----------------------
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add --all'
alias gau='git add --update'
alias gb='git branch'
alias gbd='git branch --delete '
alias gc='git commit'
alias gcm='git commit --message'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gd='git diff'
alias gda='git diff HEAD'
alias gi='git init'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gr='git rebase'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'

# ----------------------
# Git Functions
# ----------------------
# Git log find by commit message
function glf() { git log --all --grep="$1"; }

# secret stuff
[ -f ~/.zsh_secrets.sh ] &&
    source ~/.zsh_secrets.sh

y() {
    yt-dlp --write-sub --sub-lang en --convert-subs srt "$@"
}

# Don' store certain commands in history
function zshaddhistory() {
    emulate -L zsh
    if ! [[ $1 =~ ^"y\ |^ |^ls" ]] ; then
        print -sr -- "${1%%$'\n'}"
        fc -p
    else
        return 1
    fi
}


# Customize to your needs...
export GOPATH=~/go
export PATH=$HOME/apps:$HOME/.local/bin:$GOPATH/bin:$PATH:/usr/local/go/bin:$HOME/apps/google_appengine:$HOME/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)" > /dev/null

# virtualenv
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=$HOME/.virtualenvs
if [ -e "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" ]; then
    source "/usr/share/virtualenvwrapper/virtualenvwrapper.sh"
else
    echo "Please install virutalenvwrapper"
fi

# The next line updates PATH for the Google Cloud SDK.
# [ -f "$HOME/apps/google-cloud-sdk/path.zsh.inc" ] &&
#    source "$HOME/apps/google-cloud-sdk/path.zsh.inc" ||
#        echo install google cloud sdk

# The next line enables shell command completion for gcloud.
# [ -f "$HOME/apps/google-cloud-sdk/completion.zsh.inc" ] &&
#     source "$HOME/apps/google-cloud-sdk/completion.zsh.inc" ||
#        echo install shell for gcloud

function tailc() {
    tail -F "$1" |
        while read -r line;do
            printf "\033[38;5;%dm%s\033[0m\n" $((RANDOM%255)) "$line";
        done
}

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
  cat >> R/packages.R<<'EOF'
## Auto-Install the following packages
.packs <- c("tidyverse")
.success <- suppressWarnings(sapply(.packs, require, character.only = TRUE))
if (length(names(.success)[!.success])) {
  install.packages(names(.success)[!.success])
  sapply(names(.success)[!.success], require, character.only = TRUE)
}

options(stringsAsFactors = FALSE)
EOF
  cat >> main.R<<'EOF'
## This program does

main <- function() {
  source("R/packages.R")
  ## source("R/functions.R")
}
main()
EOF
  cat >> .gitignore<<'EOF'
# RStudio files
.Rproj.user/
# Don't store intermediate files
cache/*
EOF
  touch README.md
  touch graphs/.gitkeep output/.gitkeep
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

mkmakefile() {
    if [ -f Makefile ]; then
        echo "there's already a Makefile in this directory"
        return 1
    fi
    cat >> Makefile<<'EOF'
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:

# default rule
.DEFAULT_GOAL := help
.PHONY: help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sed -n 's/^\(.*\): \(.*\)##\(.*\)/\1\3/p' \
	| column -t  -s ' '

all: out/image-id ## all
.PHONY: build

clean: ## clean
> rm -rf .cache
> rm -rf out
.PHONY: clean

# Tests - re-run if any file under src has been changed since
# .cache/.tests-passed.sentinel was last touched
.cache/.tests-passed.sentinel: $(shell find src -type f)
> mkdir -p $(@D)
> node run test
> touch $@

# Build rebuild if the tests have been rebuilt
.cache/.packed.sentinel: .cache/.tests-passed.sentinel
> mkdir -p $(@D)
> webpack ..
> touch $@
EOF
}

# To change the R package directory uncomment
#R_LIBS_SITE_USER="$HOME/R/packages"

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
    cat >> "$1" <<'EOF'
#!/usr/bin/env bash
# Exit on error, undefined and prevent pipeline errors,
# use '|| true' on commands that intentionally exit non-zero
set -euo pipefail
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi
IFS=$'\n\t'
# The directory from which the script is running
readonly LOCAL_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./script.sh arg1 arg2

What the bash script does.

'
    exit
fi

main() {
    local VAR=123
}

main "$@"
EOF
}

# Show to which directory we are changing into
# cd () {
#   if builtin cd "$@"; then
#       echo "$OLDPWD -> $PWD"
#   fi
# }

# Create a symlink to the .git/hooks directory so
# that I am be able to store githooks in version control
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

function replace() {
    rg "$1" --files-with-matches | tee /dev/tty | xargs sed -i "s/$1/$2/g"
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
    read -r "REPLY?Are you sure you want to delete and wipe $*? [y/n]"
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pyenv
#export PATH="$HOME/.pyenv/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

# npm install global to homedir
export PATH=$HOME/.npm-global/bin:$PATH

# fly.io
export FLYCTL_INSTALL="$HOME/bin"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# ssh with yubikey
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/yubikey-agent/yubikey-agent.sock"

# This loads nvm
unset NPM_CONFIG_PREFIX
export NVM_DIR="$HOME/.nvm"
[ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh" ||
        echo install nvm
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Turso
export PATH="$PATH:/home/diego/.turso"
. "/home/diego/.deno/env"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
