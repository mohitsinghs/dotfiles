#!/usr/bin/env zsh

# for moving quickly
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"
alias ~="cd ~"
alias p="cd ~/Projects"
alias d="cd ~/Downloads"
alias m="cd ~/Movies"

# listing files
alias t="tree -I 'node_modules|.git|test|.DS_Store' --noreport -C -a --dirsfirst"

# extend keyboard's life
alias a2c="aria2c -x 16 -s 16"
alias mkdir="mkdir -p"
alias g="hub"
alias ytd="youtube-dl"
alias la="gls -laAhGg --color --group-directories-first"
alias ls="gls -lACG --color --group-directories-first"
alias bstart="brew services start"
alias bstop="brew services stop"
alias bslist="brew services list"
alias bup="brew upgrade && brew cleanup"

# sudoed aliases, shell reloading and pretty paths
alias sudo='sudo '
alias reload="exec $SHELL -l"
alias path='echo -e ${PATH//:/\\n}'


export EDITOR='subl'

# list orphan/unused brew packages so that they can be removed
function orphans () {
  brew list -1 | while read cask;
  do
    echo -ne "\x1B[1;34m $cask \x1B[0m";
    brew uses $cask --installed | awk '{printf(" %s ", $0)}';
    echo "";
  done
}
