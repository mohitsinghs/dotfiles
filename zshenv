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

# sync .sublime-project files and git hooks for all projects
function synk {
  local REPO_BASE="$HOME/Projects"
  local TEMPLATES="$HOME/Projects/dotfiles/templates"
  printf "\\033[33m ➜ \\033[0m Synchronizing Projects...\\n"

  # Check if cwd is a git repo
  function __isGit {
     return $([[ -d .git && $(git rev-parse --is-inside-work-tree 2> /dev/null) ]])
  }
  # Check if cwd have is a javascript project
  function __havePackageJSON {
    return $([[ -f "$1/package.json" ]])
  }
  # Check if cwd is a node module
  function __isNodeModule {
    return $(__havePackageJSON $1 && [[ -f "$1/index.js" || -f "$1/cli.js" ]])
  }
  # Check if cwd is bootstrapped using create-react-app
  function __isBabel {
    return $(__havePackageJSON $1) && $([[ -d "$1/src" && -d "$1/public" ]] || [[ -f "$1/.babelrc" ]])
  }
  # Check if two files have same content
  function __isNot {
    return $([[ ! -f $1 ]] || [[ -f $1 && $(cat $1) != $(cat $2) ]])
  }

  for r in $(find "$HOME/Projects" -mindepth 1 -maxdepth 1 -type d)
  do
    cd "$r"
    if __isGit; then
      # check for git hooks
      printf "  \\033[0m\\033[36m%s\\033[0m : \\033[2mChecking git-hooks\\033[0m" "$(basename "$r")"
      local HOOK="$r/.git/hooks/pre-commit"
      # either pre-commit hook does not exist or is not equal to current
      if __isNot $HOOK "$TEMPLATES/precommit" || __isNot $HOOK "$TEMPLATES/precommit-babel"; then
        if __isNodeModule "$r"; then
          cp "$TEMPLATES/precommit" "$HOOK"
          chmod +x "$HOOK"
        elif __isBabel "$r"; then
          cp "$TEMPLATES/precommit-babel" "$HOOK"
          chmod +x "$HOOK"
        fi
      fi
      printf "\\r\\033[K"
      # end check for git hooks

      # check for sublime-project
      printf "\\033[2m  \\033[0m\\033[36m%s\\033[0m : \\033[2m Checking sublime-project\\033[0m" "$(basename $r)"
      local PROJECT="$r/$(basename "$r").sublime-project"
      if __isNot $PROJECT "$TEMPLATES/project" || __isNot $PROJECT "$TEMPLATES/project-babel"; then
        if __isBabel "$r"; then
          cp "$TEMPLATES/project-babel" "$PROJECT"
        else
          cp "$TEMPLATES/project" "$PROJECT"
        fi
      fi 
      printf "\\r\\033[K"
      # end check for sublime-project
    fi
    cd $REPO_BASE
  done

  # unset temporary functions
  unset -f __isGit
  unset -f __havePackageJSON
  unset -f __isNodeModule
  unset -f __isBabel
  unset -f __isNot
  # move cursor to end of previous line
  printf "\\033[1A\\033[0C"
  printf "\\033[32m✔ \\033[0m Synchronized Successfully\\033[0m"
}
