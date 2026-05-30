# shellcheck disable=SC2034,SC1091,SC2029,SC2162
# shellcheck source=/dev/null
# zmodload zsh/zprof
# Add deno completions to search path
if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then export FPATH="$HOME/.zsh/completions:$FPATH"; fi

DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

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
if [ "$(uname)" = "FreeBSD" ] || [ "$(uname)" = "Darwin" ]; then
  alias ports='sockstat -l46'
else
  alias ports='netstat -tulanp'
fi
alias cd..='cd ..'
if ls --group-directories-first -d . >/dev/null 2>&1; then
  alias l='ls -laF -h --group-directories-first'
  alias ll='ls -1aF -h --group-directories-first'
else
  alias l='ls -laFh'
  alias ll='ls -1aFh'
fi
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
alias nz="nano ~/.zshrc && . ~/.zshrc"
alias bat="batcat"

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
alias gpom='git push origin master'
alias gpod='git push origin develop'
# Save temporary work
alias gwip='git add -A; git commit -m "WIP: Work in progress"'
# Undo temporary work
alias gunwip='git reset HEAD~1'

# ----------------------
# Disable ssh-keygen
# ----------------------
# alias ssh-keygen='echo "ssh-keygen disabled, export SSH_ASKPASS=\"\" && export SSH_ASKPASS_REQUIRE=\"\" before enabling"'


# ----------------------
# Git Functions
# ----------------------
# Git log find by commit message
function glf() { git log --all --grep="$1"; }


function git_insight() {
    echo "What Changes the Most"
    echo "git log --format=format: --name-only --since=\"1 year ago\" | sort | uniq -c | sort -nr | head -20"
    git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -20

    echo "Who Built This"
    echo "git shortlog -sn --no-merges"
    git shortlog -sn --no-merges

    echo "Where Do Bugs Cluster"
    echo "git log -i -E --grep=\"fix|bug|broken\" --name-only --format='' | sort | uniq -c | sort -nr | head -20"
    git log -i -E --grep="fix|bug|broken" --name-only --format='' | sort | uniq -c | sort -nr | head -20

    echo "Is This Project Accelerating or Dying"
    echo "git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c"
    git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c
}

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

function sshtmux() {
  if [[ -z $1 ]]; then
    echo "Specify a host"
    return 1
  fi
  ssh "$@" -t "tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux"
}

function sshrc() {
  if [[ -z $1 ]]; then
    echo "Specify a host"
    return 1
  fi
  local RC_DATA
  RC_DATA=$(base64 <"${HOME}"/.bashrc | tr -d '\r\n')
  ssh -t "$@" "MY_TMP_DIR=\$(mktemp -d);echo \"${RC_DATA}\" | { base64 --decode 2>/dev/null || base64 -d 2>/dev/null || base64 -D 2>/dev/null; } > \$MY_TMP_DIR/\${USER}_bashrc; bash --rcfile \$MY_TMP_DIR/\${USER}_bashrc; rm \$MY_TMP_DIR/\${USER}_bashrc"
}

function sshtmuxrc() {
  if [[ -z $1 ]]; then
    echo "Specify a host"
    return 1
  fi
  local RC_DATA
  RC_DATA=$(base64 <"${HOME}"/.bashrc | tr -d '\r\n')
  ssh -t "$@" "MY_TMP_DIR=\$(mktemp -d);echo \"${RC_DATA}\" | { base64 --decode 2>/dev/null || base64 -d 2>/dev/null || base64 -D 2>/dev/null; } > \$MY_TMP_DIR/\${USER}_bashrc; tmux attach-session -t ssh_tmux \"bash --rcfile \$MY_TMP_DIR/\${USER}_bashrc\" || tmux new-session -s ssh_tmux \"bash --rcfile \$MY_TMP_DIR/\${USER}_bashrc\"; rm \$MY_TMP_DIR/\${USER}_bashrc"
}

function sshtmux() {
    if [[ -z $1 ]]; then
        echo "Specify a host"
        return 1
    fi
    ssh "$@" -t "tmux attach-session -t sshtmux || tmux new-session -s sshtmux"
}

# creates a directory and cds into it
function mkcd() {
    mkdir -p "$1" && cd "$1" || exit
}

# lists zombie processes
function zombie() {
    ps aux | awk '{if ($8=="Z") { print $2 }}'
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
LOCAL_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
readonly LOCAL_DIR

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

pass () {
  local PREFIX
  PREFIX="${PASSAGE_DIR:-$HOME/.passage/store}"
  local FZF_DEFAULT_OPTS
  FZF_DEFAULT_OPTS=""
  local name
  name="$(find "$PREFIX" -type f -name '*.age' | \
      sed -e "s|$PREFIX/||" -e 's|\.age$||' | \
      fzf --height 40% --reverse --no-multi)"
  passage "${@}" "$name"
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
export PATH="$PATH:$HOME/.turso"

[[ -f "$HOME/.deno/env" ]] && . "$HOME/.deno/env"

[[ -f "$HOME/.atuin/bin/env" ]] && . "$HOME/.atuin/bin/env"

eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

eval "$(atuin init zsh --disable-up-arrow)"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
#        . "$HOME/miniconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="$HOME/miniconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

#zprof

#export OPENAI_API_KEY=$(passage show OPENAI_API_KEY)


print_error_box() {
    local msg=" $1 "
    local width=${#msg}
    local border

    border=$(printf '%*s' "$width" '')
    border=${border// /─}

    print -P "%F{red}┌${border}┐%f"
    print -P "%F{red}│%f%K{red}%F{white}${msg}%f%k%F{red}│%f"
    print -P "%F{red}└${border}┘%f"
}

typeset -g LAST_CMD=""

preexec() {
    LAST_CMD="$1"
}

precmd() {
    local exit_code=$?
    if (( exit_code != 0 )) && [[ "$LAST_CMD" == git* ]]; then
        print_error_box "ERROR"
    fi
}
