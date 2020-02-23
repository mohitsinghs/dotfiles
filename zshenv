#!/usr/bin/env zsh

# for moving quickly
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

# favourite locations
alias ~="cd ~"
alias p="cd ~/Projects"
alias d="cd ~/Designs"
alias m="cd ~/Movies"

# A less noisy tree list
alias t="tree -I 'node_modules|.git|test|venv|env|.DS_Store' --noreport -C -a --dirsfirst"

# download with aria2 using 16 connections
alias a2c="aria2c -x16 -s16"

# make nested directories
alias mkdir="mkdir -p"

# common shortcuts
alias git="hub"
alias g="git"
alias vi="nvim"
alias vim="nvim"
alias py="python"

# shortcut for my youtube-dl fork
alias ytd="ytd --external-downloader aria2c"
alias ytdm="ytd -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --crop-thumbnail --add-metadata -o '%(title)s.%(ext)s'"

# better ls output
alias la="gls -laAhGg --color --group-directories-first"
alias ls="gls -lACG --color --group-directories-first"

# brew shortcuts
alias bstart="brew services start"
alias bstop="brew services stop"
alias blist="brew services list"
alias bup="brew upgrade"

# yarn shortcuts
alias yi="yarn"
alias ya="yarn add"
alias yd="yarn add --dev"
alias yu="yarn upgrade-interactive --latest"

# sudoed aliases, shell reloading and pretty paths
alias sudo="sudo "
alias reload="exec $SHELL -l"
alias path="echo -e ${PATH//:/\\\n}"

# Clear dns cache
function cleardns {
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
}

# Update blocklist
function upblock {
  echo -n "Updating host files..."
  curl -fsSL "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts" | sudo tee /etc/hosts > /dev/null
  echo "Done."
}

# Update everything
function upall {
  brew upgrade
  vim +PlugUpdate +qa
  npm up -g
  softwareupdate -ia
  gem update --system
  gem update
}

# list orphan/unused brew packages so that they can be removed
function orphan {
  brew list -1 | while read cask;
  do
    echo -ne "\x1B[1;34m $cask \x1B[0m";
    brew uses $cask --installed | awk '{printf(" %s ", $0)}';
    echo "";
  done
}

# for moving quickly into my projects
function repo {
    REPO_BASE="$HOME/Projects"
    REPO_PATH=$(find "$REPO_BASE" -mindepth 1 -maxdepth 1 -type d -name "*$1*" | head -n 1)
    if [[ -z $1 ]]; then
        cd "$REPO_BASE"
    else
        cd "$REPO_PATH"
    fi
}
