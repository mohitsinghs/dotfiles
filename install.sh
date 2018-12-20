#!/bin/bash
#
# automated configuration for macos
#
# Author: Mohit Singh
# https://github.com/mohitsinghs/dotfiles

set -e

success () {
  printf "\\033[32m ✔ \\033[0m\\n" >&2
}

fail () {
  printf "\\n\\033[31m ✖ \\033[0m $1\\n" >&2
  exit 1
}

info () {
  printf "\\033[33m ➜ \\033[0m $1" >&2
}

# define variables
DOTLOC=$HOME/Projects/dotfiles
ZSH_USERS=https://github.com/zsh-users
FUNPATH=/usr/local/share/zsh/site-functions

# exit if macos is not found
info "Checking system..."
if [[ $(uname) != 'Darwin' ]]; then
  fail "You are not on a mac."
else
  success
fi

# exit if dotfiles exists
info "Looking for dotfiles..."
if [[ -d  $DOTLOC ]]; then
  fail "\\033[2m$HOME/dotfiles\\033[0m already exists."
else
  success
fi

# No help from next launch
touch ~/.hushlogin

# create dotfiles directory and clone
info "Cloning dotfiles..."
[[ ! -d $HOME/Projects ]] && mkdir -p $HOME/Projects
git clone -q https://github.com/mohitsinghs/dotfiles.git $DOTLOC
success


# install homebrew if missing
if [[ ! -x "$(command -v brew)" ]]; then
  info "Installing homebrew...\\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  info "Homebrew is already installed.\\n"
fi

# install packages
info "Installing packages..."
brew bundle install --file=$DOTLOC/Brewfile >/dev/null
success

# install iStats for battery stats
if [[ ! -x "$(command -v iStats)" ]]; then
  info "Installing iStats..."
  gem install iStats > /dev/null
  success
else
  info "iStats is already installed.\\n"
fi

# link required files
info "Linking Files..."
for file in zshrc zshenv gitconfig gitignore
do
  rm ~/.$file &>/dev/null
  ln -s $DOTLOC/$file ~/.$file
done
success

# change default shell to zsh
chsh -s zsh

info "Installing pure prompt..."
# cleanup old prompt files
if [[ -x $FUNPATH/prompt_pure_setup && -x $FUNPATH/async ]]; then
  rm -f $FUNPATH/prompt_pure_setup
  rm -f $FUNPATH/async
fi
# install pure prompt
curl https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh --create-dirs -fsSLo $FUNPATH/prompt_pure_setup
curl https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh -fsSLo $FUNPATH/async
chmod +x $FUNPATH/prompt_pure_setup
chmod +x $FUNPATH/async
success

# reload shell
exec zsh
