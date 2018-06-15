#!/usr/bin/env zsh

# for moving quickly
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"
alias ~="cd ~"
alias p="cd ~/Projects"

# listing files
alias t="tree"

# npm shortcuts
alias ni="npm info"
alias nr="npm run"
alias ns="npm search"
alias nid="npm install -D"
alias nis="npm install"
alias nrm="npm uninstall"

# extend keyboard's life
alias tmux="tmux -2"
alias a2c="aria2c -x 16 -s 16"
alias mkdir="mkdir -p"
alias g="hub"
alias ytd="youtube-dl"

# sudoed aliases, shell reloading and pretty paths
alias sudo='sudo '
alias reload="exec $SHELL -l"
alias path='echo -e ${PATH//:/\\n}'

if [[ $(uname) == 'Darwin' ]]; then
  alias la="gls -laAhGg --color --group-directories-first"
  alias ls="gls -lACG --color --group-directories-first"
  alias d="cd ~/Downloads"
  alias m="cd ~/Movies"
  alias bstart="brew services start"
  alias bstop="brew services stop"
  alias bslist="brew services list"
  alias bup="brew upgrade && brew cleanup"

  # list orphan/unused brew packages so that they can be removed
  function orphans () {
    brew list -1 | while read cask;
    do
      echo -ne "\x1B[1;34m $cask \x1B[0m";
      brew uses $cask --installed | awk '{printf(" %s ", $0)}';
      echo "";
    done
  }
elif [[ $(uname) == 'Linux' ]]; then
  alias la="ls -laAhGg --color --group-directories-first"
  alias ls="ls -lACG --color --group-directories-first"
  alias tdf="transmission-daemon -f"
  alias d="cd /sdcard/Download"

  # Share files with mac
  function up () {
    scp $2 "mohit@192.168.$1:Downloads"
  }
  function down () {
    scp "mohit@192.168.$1:Downloads/$2" .
  }
fi