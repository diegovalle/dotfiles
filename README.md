# Dotfiles for diegovalle

## Requirements

- Git
- Curl

## Install

Install config tracking in your $HOME by running:

.dotfiles == directory to store the git database
dotfiles == git alias

git clone --recursive https://github.com/diegovalle/dotfiles.git

```sh
git clone --bare https://bitbucket.org/durdn/cfg.git $HOME/.dotfiles
function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p .config-backup
dfl checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
dfl checkout
dfl config status.showUntrackedFiles no
```
