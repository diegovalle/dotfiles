# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
 plugins=(git pep8 git-flow pylint python)

# Who doesn't want home and end to work?
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

DISABLE_UPDATE_PROMPT=true

# virtualenv
source virtualenvwrapper.sh

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

### VirtualEnv ###
# pip should only run if there is a virtualenv currently activated
# prevents accidentally installing packages without a virtualenv
export PIP_REQUIRE_VIRTUALENV=true
# create syspip workaround
syspip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
syspip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}



alias mkdir='mkdir -pv'
# install  colordiff package :)
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias diff='colordiff'
alias ports='netstat -tulanp'

### Extra ZSH options ###
# If querying the user before executing `rm *' or `rm
# path/*', first wait ten seconds and ignore anything typed
# in that time. This avoids the problem of reflexively
# answering `yes' to the query when one didn't really mean
# it.
setopt RM_STAR_WAIT

#Stop R from promping to save workspace
alias R='R --no-save --no-restore-data --quiet'

#R libraries in a nice place
R_LIBS="/home/diego/R/rpackages"
export R_LIBS

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
export PATH=/home/diego/apps/google_appengine:/home/diego/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

[ -s "/home/diego/.nvm/nvm.sh" ] && . "/home/diego/.nvm/nvm.sh" # This loads nvm
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# The next line updates PATH for the Google Cloud SDK.
source '/home/diego/apps/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/home/diego/apps/google-cloud-sdk/completion.zsh.inc'

alias youtube-dl='youtube-dl  --write-sub --sub-lang en --convert-subs srt'
alias dfl='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
PROMPT='${ret_status} %{$fg[cyan]%}/${(j:/:)${(M)${(s:/:)PWD:h}#(|.)[^.]}}/${PWD:t}%{$reset_color%} $(git_prompt_info)'
