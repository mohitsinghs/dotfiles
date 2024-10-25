if status is-interactive
  set -g fish_greeting

  # repo jump
  source (repo sh fish -b z | psub)

  # enable fzf shell integration
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
    --layout=reverse \
    --color=fg:#c0caf5,bg:#24283b,hl:#ff9e64 \
    --color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
    --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
    --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
  fzf --fish | source

  # starship prompt
  starship init fish | source
  export DIRENV_LOG_FORMAT=
  export NODE_REPL_HISTORY=""
  direnv hook fish | source

  export GOROOT="/usr/lib/go"
  export GOPATH="$HOME/.go"
  export CARGOPATH="$HOME/.cargo"
  export RUSTC_WRAPPER=sccache

  set PATH = $CARGOPATH/bin $GOROOT/bin $GOPATH/bin $HOME/.local/bin $PATH

  export LC_ALL=en_US.UTF-8
  export LC_CTYPE=en_US.UTF-8

  # for moving quickly
  alias ..="cd .."
  alias ...="cd ../.."
  alias ....="cd ../../.."
  alias p="cd ~/Projects"

  # Use clipboard for xclip
  alias xclip="xclip -selection clipboard"

  # download with aria2 using 16 connections
  alias a2c="aria2c -x16 -s16"

  # make nested directories
  alias mkdir="mkdir -p"

  # alias for tools
  alias g="git"
  alias vi="nvim"
  alias vim="nvim"
  alias py="python"
  alias c="cargo"
  alias d="docker"
  alias hf="hyperfine"
  alias rs="rustc -C opt-level=z -C strip=symbols"
  alias pn="pnpm"
  alias pm="sudo pacman"

  # better ls output using eza
  alias la="eza -la --group-directories-first"
  alias ll="eza -l --group-directories-first"
  alias ls="eza"

  # sudoed aliases, shell reloading and pretty paths
  alias sudo="sudo "
  alias reload="exec $SHELL -l"
end
