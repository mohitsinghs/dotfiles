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
alias t="tree -I 'node_modules|.git|test|.DS_Store' --noreport -C -a --dirsfirst"

# be less destructive
alias rm="trash"

# download with aria2 using 16 connections
alias a2c="aria2c -x16 -s16"

# make nested directories
alias mkdir="mkdir -p"

# git shortcut
alias g="hub"

# youtube-dl
alias ytd="youtube-dl"
alias ytdmp3="youtube-dl -x --audio-format mp3 --audio-quality 0"

# gnu coreutils ls for better output
alias la="gls -laAhGg --color --group-directories-first"
alias ls="gls -lACG --color --group-directories-first"

# brew shortcuts
alias bstart="brew services start"
alias bstop="brew services stop"
alias bslist="brew services list"
alias bup="brew upgrade && brew cleanup"

# yarn shortcuts
alias yi="yarn"
alias yf="yarn --offline"
alias yn="yarn --no-lockfile"
alias yd="yarn add --dev"
alias ya="yarn add"
alias yup="yarn upgrade-interactive --latest"

# sudoed aliases, shell reloading and pretty paths
alias sudo="sudo "
alias reload="exec $SHELL -l"
alias path="echo -e ${PATH//:/\\\n}"

# avoid typing cd
setopt autocd

# list orphan/unused brew packages so that they can be removed
function orphans () {
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

# Check if cwd is a git repo
function __isGit {
   return $([[ -d .git && $(git rev-parse --is-inside-work-tree 2> /dev/null) ]])
}

# Check if cwd have is a javascript project
function __havePackageJSON {
  return $([[ -f "$1/package.json" ]])
}

# Format current project with eslint and prettier
function commit {
  if __isGit && __havePackageJSON $(pwd); then
      opts='--no-semi --single-quote --jsx-single-quote'
      prettier --write ${opts} "**/*.{js,jsx,vue,json,yaml,md,html,css,scss}"
      eslint "**/*.{js,jsx,vue}"
      exit_code=$?
      if [ ${exit_code} -ne 0 ]; then
        echo "Commit failed due to linting errors"
        exit ${exit_code}
      else
        git commit -a
      fi
  else
    echo "You need to be in a git repo with package.json. Sorry!"
  fi
}
