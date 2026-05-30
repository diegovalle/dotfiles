#!/usr/bin/env bash
#
# shellcheck source=/dev/null
# shellcheck disable=SC2029
# shellcheck disable=SC2006
#
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
# Save 10,000,000 lines of history in memory
HISTSIZE=10000000
# Save 20,000,000 lines of history to disk (will have to grep ~/.bash_history for full listing)
HISTFILESIZE=20000000
# Ignore redundant or space commands
HISTCONTROL=ignoreboth
HISTIGNORE='ls:bg:fg:history'
PROMPT_COMMAND='history -a'
# 2008-08-05 19:02:39
HISTTIMEFORMAT='%F %T '
# Multiple commands on one line show up as a single line
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [[ -v debian_chroot ]] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

if [[ -v debian_chroot ]] && [ -r /etc/debian_chroot ]; then
  if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi
  unset color_prompt force_color_prompt

  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
  xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *) ;;
  esac
fi
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  if test -r ~/.dircolors; then
    eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  fi
else
  export CLICOLOR=1
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
fi

# shellcheck disable=SC2262
if ls --color=auto -d . >/dev/null 2>&1; then
  alias ls='ls --color=auto'
elif ls -G -d . >/dev/null 2>&1; then
  alias ls='ls -G'
fi

if grep --color=auto -q a <(echo a) 2>/dev/null; then
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -E '\''s/^[[:space:]]*[0-9]+[[:space:]]*//;s/[;&|][[:space:]]*alert$//'\'')"'

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

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

function sshtmux() {
  if [[ -z $1 ]]; then
    echo "Specify a host"
    return 1
  fi
  ssh "$@" -t "tmux attach-session -t sshtmux || tmux new-session -s sshtmux"
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
  cat >>analysis.R <<EOF
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
  cat >>.gitignore <<EOF
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
  } >"$*".Rproj
  return 0
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
  cat >>"$1" <<EOF
  #!/usr/bin/env bash
  # Exit on error, undefined and prevent pipeline errors,
  # use '|| true' on commands that intentionally exit non-zero
  set -euo pipefail
  if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi
  IFS=$'\n\t'
  # The directory from which the script is running
  LOCAL_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
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
# cd() {
#   if builtin cd "$@"; then
#     echo "$OLDPWD -> $PWD"
#   fi
# }

# Create a symlink to the .git/hooks directory so
# that I can be able to store githooks in version control
install_hook() {
  if [[ -z $1 ]]; then
    echo Usage: install_hook hook.sh
  fi

  if GITDIR=$(git rev-parse --git-dir)/hooks; then
    echo "Must be run inside a git repository"
    return 1
  fi
  if [ -f "$1" ]; then
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

function extract() {
  if [ -f "$1" ]; then
    case "$1" in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz) tar xzf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) unrar e "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar xf "$1" ;;
    *.tbz2) tar xjf "$1" ;;
    *.tgz) tar xzf "$1" ;;
    *.zip) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *.deb) ar x "$1" ;;
    *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

wipe() {
  if [[ -z "$1" ]]; then
    echo "Usage: wipe file | directory"
    return 1
  fi
  read -r -p "Are you sure you want to wipe $*? [y/N] " response
  response=${response,,} # tolower
  if [[ "$response" =~ ^(yes|y)$ ]]; then
    echo # (optional) move to a new line
    for PASSED in "$@"; do
      if [[ -d "$PASSED" ]]; then
        if command -v shred >/dev/null 2>&1; then
          find "$PASSED" -depth -type f -exec shred -v -n 1 {} \;
          sync
          find "$PASSED" -depth -type f -exec shred -v -n 0 -z -u {} \;
        else
          find "$PASSED" -depth -type f -exec rm -P {} \; 2>/dev/null || find "$PASSED" -depth -type f -exec rm -f {} \;
        fi
      elif [[ -f "$PASSED" ]]; then
        if command -v shred >/dev/null 2>&1; then
          shred -v -n 1 "$PASSED"
          sync
          shred -v -n 0 -z -u "$PASSED"
        else
          rm -P "$PASSED" 2>/dev/null || rm -f "$PASSED"
        fi
      else
        echo "$PASSED is not valid file or directory"
        return 1
      fi
    done
  else
    return 1
  fi

}

## Functions for the bash prompt

function nonzero_return() {
  RETVAL=$?
  [ $RETVAL -ne 0 ] && echo "$RETVAL "
}

# get current branch in git repo
function parse_git_branch() {
  BRANCH=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ ! "${BRANCH}" == "" ]; then
    STAT=$(parse_git_dirty)
    echo "[${BRANCH}${STAT}]"
  else
    echo ""
  fi
}

# get current status of git repo
function parse_git_dirty {
  status=$(git status 2>&1 | tee)
  dirty=$(
    echo -n "${status}" 2>/dev/null | grep "modified:" &>/dev/null
    echo "$?"
  )
  untracked=$(
    echo -n "${status}" 2>/dev/null | grep "Untracked files" &>/dev/null
    echo "$?"
  )
  ahead=$(
    echo -n "${status}" 2>/dev/null | grep "Your branch is ahead of" &>/dev/null
    echo "$?"
  )
  newfile=$(
    echo -n "${status}" 2>/dev/null | grep "new file:" &>/dev/null
    echo "$?"
  )
  renamed=$(
    echo -n "${status}" 2>/dev/null | grep "renamed:" &>/dev/null
    echo "$?"
  )
  deleted=$(
    echo -n "${status}" 2>/dev/null | grep "deleted:" &>/dev/null
    echo "$?"
  )
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

##
## ARRANGE $PWD AND STORE IT IN $NEW_PWD
## * The home directory (HOME) is replaced with a ~
## * The last pwdmaxlen characters of the PWD are displayed
## * Leading partial directory names are striped off
##  /home/me/stuff -> ~/stuff (if USER=me)
##  /usr/share/big_dir_name -> ../share/big_dir_name (if pwdmaxlen=20)
##
## Original source: WOLFMAN'S color bash promt
## https://wiki.chakralinux.org/index.php?title=Color_Bash_Prompt#Wolfman.27s
##
bash_prompt_command() {
  # How many characters of the $PWD should be kept
  local pwdmaxlen=25

  # Indicate that there has been dir truncation
  local trunc_symbol=".."

  # Store local dir
  local dir=${PWD##*/}

  # Which length to use
  pwdmaxlen=$(((pwdmaxlen < ${#dir}) ? ${#dir} : pwdmaxlen))

  local NEW_PWD=${PWD/#$HOME/\~}

  local pwdoffset=$((${#NEW_PWD} - pwdmaxlen))

  # Generate name
  if [ ${pwdoffset} -gt "0" ]; then
    NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
    NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
  fi
  echo "$NEW_PWD"
}

#export PATH="$HOME/.pyenv/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
umask 077

# npm install global to homedir
export PATH=$HOME/.npm-global/bin:$PATH

# fly.io
export FLYCTL_INSTALL="$HOME/bin"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

include() {
  if [[ -f "$1" ]]; then
    source "$1"
  fi
}

# ssh with yubikey
if [[ -v XDG_RUNTIME_DIR ]]; then
  export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/yubikey-agent/yubikey-agent.sock"
fi
include "$HOME/.deno/env"
include "$HOME/.atuin/bin/env"

include "$HOME/.bash-preexec.sh"
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init bash)"
fi
# make less more friendly for non-text input files, see lesspipe(1)
if command -v /usr/bin/lesspipe >/dev/null 2>&1; then
  eval "$(SHELL=/bin/sh lesspipe)"
fi

include "$HOME/.local/share/bash-completion/completions/deno.bash"
if [ -f /etc/bash_completion.d/git-prompt ]; then
  source /etc/bash_completion.d/git-prompt
else
  # Source the git-prompt script in freeBSD
  include /usr/local/share/git-core/contrib/completion/git-prompt.sh
fi

# Enable additional git status indicators (optional)
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUPSTREAM="auto"
git_ps() {
  printf "%s\n" "$(__git_ps1 " (%s)")"
}

function _update_prompt() {
  # https://serverfault.com/questions/187712/how-to-determine-if-im-logged-in-via-ssh
  local SESSION_TYPE
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    SESSION_TYPE=remote/ssh
  else
    case $(ps -o comm= -p $PPID) in
    sshd | */sshd) SESSION_TYPE=remote/ssh ;;
    esac
  fi
  # Capture the exit status of the last command immediately
  #local EXIT="$?"

  # Text Formatting & Reset
  local RESET="\[\e[0m\]"
  local BOLD="\[\e[1m\]"

  # Exit code in Red (only if it's non-zero, or always if you prefer)
  # local EXIT_STR=""
  # if [ $EXIT -ne 0 ]; then
  #   EXIT_STR="\[\e[31m\]$EXIT $RESET"
  # else
  #   EXIT_STR="\[\e[32m\]0 $RESET" # Green for 0, change to \e[31m if you want 0 in red too
  # fi

  # Arrow Symbol
  local ARROW=""

  # Base components
  local RET="\[\e[93;41m\]\`nonzero_return\`${RESET}"

  # Four types of prompt: remote and root
  if [ "$SESSION_TYPE" == "remote/ssh" ]; then
    if [ "$EUID" -eq 0 ]; then
      # -----------------------------------------------------------------
      # ROOT PROMPT
      # -----------------------------------------------------------------
      # 1. Username: Bright Yellow text (\e[91m), Dark Red bg (\e[41m)
      local SEG_USER="\[\e[93;41m\] \u "
      # 2. Arrow 1: Dark Red text (\e[31m), Blue bg (\e[44m)
      local ARROW_1="\[\e[31;44m\]$ARROW"
      # 3. Hostname: Black text (\e[30m), Blue bg (\e[44m)
      local SEG_HOST="\[\e[30;44m\] \h "
      # 4. Arrow 2: Blue text (\e[30m), White bg (\e[47m)
      local ARROW_2="\[\e[34;47\]$ARROW"
      # 5. Directory: Black text (\e[30m), White bg (\e[47m)
      local SEG_DIR="\[\e[30;47m\] \w "
      # 6. Arrow 3: White text (\e[37m), Default bg (\e[49m)
      local ARROW_3="\[\e[37;49m\]$ARROW$RESET"

      PS1="${RET}${SEG_USER}${BOLD}${ARROW_1}${SEG_HOST}${ARROW_2}${SEG_DIR}${ARROW_3} "
    else
      # -----------------------------------------------------------------
      # USER PROMPT (NOT ROOT)
      # -----------------------------------------------------------------
      # 1. Username: Black text (\e[30m), Bright Yellow bg (\e[103m)
      local SEG_USER="\[\e[30;103m\] \u "
      # 2. Arrow 1: Bright Yellow text (\e[94m), Blue bg (\e[44m)
      local ARROW_1="\[\e[93;44m\]$ARROW"
      # 3. Hostname: Black text (\e[30m), Blue bg (\e[44m)
      #    Note: For the arrow transition to make sense color-wise,
      #    we'll make the arrow match the next segment's background.
      #local ARROW_HOST_PRE="\[\e[47;34m\]$ARROW" # White bg, Blue text transition
      local SEG_HOST="\[\e[30;44m\] \h "
      # 4. Arrow 2: Blue text (\e[34m), White bg (\e[47m)
      local ARROW_2="\[\e[34;47m\]$ARROW"
      # 5. Directory: Black text (\e[30m), White bg (\e[47m)
      local SEG_DIR="\[\e[30;47m\] \w "
      # 6. Arrow 3: White text (\e[37m), Yellow bg
      local ARROW_3="\[\e[37;43m\]$ARROW"
      # 6. Arrow 3: Black text (\e[37m), Yellow bg
      local GIT="\[\e[30;43m\]\`git_ps\`$RESET"

      # 6. Arrow 4: Yellow text (\e[30m), Default bg
      local ARROW_4="\[\e[33;49m\]$ARROW$RESET"

      PS1="${RET}${SEG_USER}${ARROW_1}${SEG_HOST}${ARROW_2}${SEG_DIR}${ARROW_3}${GIT}${ARROW_4}"
    fi
  else
    if [ "$EUID" -eq 0 ]; then
      # -----------------------------------------------------------------
      # ROOT PROMPT
      # -----------------------------------------------------------------
      # 1. Username: Bright Yellow text (\e[91m), Dark Red bg (\e[41m)
      local SEG_USER="\[\e[93;41m\] \u "
      # 2. Arrow 1: Dark Red text (\e[31m), Blue bg (\e[44m)
      local ARROW_1="\[\e[31;44m\]$ARROW"
      # 3. Hostname: Black text (\e[30m), Blue bg (\e[44m)
      local SEG_HOST="\[\e[30;44m\] \h "
      # 4. Arrow 2: Blue text (\e[30m), White bg (\e[47m)
      local ARROW_2="\[\e[34;47\]$ARROW"
      # 5. Directory: Black text (\e[30m), White bg (\e[47m)
      local SEG_DIR="\[\e[30;47m\] \w "
      # 6. Arrow 3: White text (\e[37m), Default bg (\e[49m)
      local ARROW_3="\[\e[37;49m\]$ARROW$RESET"

      PS1="${RET}${SEG_USER}${BOLD}${ARROW_1}${SEG_HOST}${ARROW_2}${SEG_DIR}${ARROW_3} "
    else
      # -----------------------------------------------------------------
      # USER PROMPT (NOT ROOT)
      # -----------------------------------------------------------------
      # 1. Username: Black text (\e[97m), Bright Blue bg (\e[104m)
      local SEG_USER="\[\e[30;104m\] \u "
      # 2. Arrow 1: Blue text (\e[94m), Cyan bg (\e[46m)
      local ARROW_1="\[\e[94;46m\]$ARROW"
      # 3. Hostname: Black text (\e[30m), Blue bg (\e[44m)
      #    Note: For the arrow transition to make sense color-wise,
      #    we'll make the arrow match the next segment's background.
      #local ARROW_HOST_PRE="\[\e[47;34m\]$ARROW" # White bg, Cyan text transition
      local SEG_HOST="\[\e[30;46m\] \h "
      # 4. Arrow 2: Cyan text (\e[36m), White bg (\e[47m)
      local ARROW_2="\[\e[36;47m\]$ARROW"
      # 5. Directory: Black text (\e[30m), White bg (\e[47m)
      local SEG_DIR="\[\e[30;47m\] \w "
      # 6. Arrow 3: White text (\e[37m), Yellow bg
      local ARROW_3="\[\e[37;43m\]$ARROW"
      # 6. Arrow 3: Black text (\e[37m), Yellow bg
      local GIT="\[\e[30;43m\]\`git_ps\`$RESET"

      # 6. Arrow 4: Yellow text (\e[30m), Default bg
      local ARROW_4="\[\e[33;49m\]$ARROW$RESET"

      PS1="${RET}${SEG_USER}${ARROW_1}${SEG_HOST}${ARROW_2}${SEG_DIR}${ARROW_3}${GIT}${ARROW_4}"
    fi
  fi
}

# Run the function before every prompt render
PROMPT_COMMAND=_update_prompt
