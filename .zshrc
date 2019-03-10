export TERM="xterm-256color"
DEFAULT_USER=diego

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"
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
plugins=(git pep8 git-flow pylint python zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Who doesn't want home and end to work?
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

#DISABLE_UPDATE_PROMPT=true

# virtualenv
source /usr/local/bin/virtualenvwrapper.sh

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

alias youtube-dl='youtube-dl --write-sub --sub-lang en --convert-subs srt '
alias dfl='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

### Extra ZSH options ###
# If querying the user before executing `rm *' or `rm
# path/*', first wait ten seconds and ignore anything typed
# in that time. This avoids the problem of reflexively
# answering `yes' to the query when one didn't really mean
# it.
setopt RM_STAR_WAIT

export HISTCONTROL=ignorespace

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
[ -s "/home/diego/.nvm/nvm.sh" ] && . "/home/diego/.nvm/nvm.sh" # This loads nvm

# The next line updates PATH for the Google Cloud SDK.
[ -f /home/diego/apps/google-cloud-sdk/path.zsh.inc ] && source '/home/diego/apps/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
[ -f /home/diego/apps/google-cloud-sdk/completion.zsh.inc ] && source '/home/diego/apps/google-cloud-sdk/completion.zsh.inc'

# creates a directory and cds into it
function mkd() {
    mkdir -p "$@" && cd "$@"
}

# lists zombie processes
function zombie() {
    ps aux | awk '{if ($8=="Z") { print $2 }}'
}

diceware () {
  if [[ -z $1 ]] then
    NUMWORDS=6
  else
    NUMWORDS=$1
  fi
  echo Your password has $(($NUMWORDS * 12.9)) bits of entropy
  shuf --random-source=/dev/urandom ~/Documents/eff_large_wordlist.txt | \
       head -n$NUMWORDS | \
       awk -F" " '{printf "%s",$2} END {print ""}' | \
       sed 's/$//'

}

diceware_short () {
  if [[ -z $1 ]] then
    NUMWORDS=6
  else
    NUMWORDS=$1
  fi
  echo Your password has $(($NUMWORDS * 10.3)) bits of entropy
  shuf --random-source=/dev/urandom ~/Documents/eff_small_wordlist_1.txt | \
       head -n$NUMWORDS | \
       awk -F" " '{printf "%s",$2} END {print ""}'| \
       sed 's/$//'

}

curlbench() {
  if [[ -z $1 ]] then
    echo "Usage: $0 http://example.com"
  fi
  curl -w "@/home/diego/Documents/curl-format.txt" -o /dev/null -s $1
}

## R programming stuff

#Stop R from promping to save workspace
alias R='R --no-save --no-restore-data --quiet'

#R libraries in a nice place
R_LIBS="/home/diego/R/rpackages"
export R_LIBS

rproject() {
  if [ -z "$@" ]; then
    echo "forgot to specify the directory name"
    return 0
  fi
  if [ -d "$@" ]; then
    echo "directory already exists"
    return 0
  fi
  mkdir -p "$@/graphs"
  mkdir -p "$@/R"
  mkdir -p "$@/output"
  mkdir -p "$@/data/$(date +%Y-%m-%d)"
  mkdir -p "$@/cache"
  mkdir -p "$@/meta"
  cd "$@"
  cat >> analysis.R<<HERE
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
HERE
  touch .gitignore
  touch README.md
  printf "Version: 1.0\n" > "$@".Rproj
  printf "\n" >> "$@".Rproj
  printf "RestoreWorkspace: Default\n" >> "$@".Rproj
  printf "SaveWorkspace: Default\n" >> "$@".Rproj
  printf "AlwaysSaveHistory: Default\n" >> "$@".Rproj
  printf "\n" >> "$@".Rproj
  printf "EnableCodeIndexing: Yes\n" >> "$@".Rproj
  printf "UseSpacesForTab: Yes\n" >> "$@".Rproj
  printf "NumSpacesForTab: 2\n" >> "$@".Rproj
  printf "Encoding: UTF-8\n" >> "$@".Rproj
  printf "\n" >> "$@".Rproj
  printf "RnwWeave: Sweave\n" >> "$@".Rproj
  printf "LaTeX: pdfLaTeX\n" >> "$@".Rproj
  return 1
}

# To change the R package directory uncomment
#R_LIBS_SITE_USER="/home/diego/R/packages"

cd () {
  builtin cd "$@"
  echo "$OLDPWD -> $PWD"
}

# added by travis gem
[ -f /home/diego/.travis/travis.sh ] && source /home/diego/.travis/travis.sh
