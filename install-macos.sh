#!/bin/sh

unzip ~/Downloads/secure.zip -d ~

# Install homebrew and tools
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew bundle install $DOTLOC/Brewfile

# Clone dotfiles
DOTLOC=~/Projects/dotfiles
mkdir -p $DOTLOC
git clone git@github.com:mohitsinghs/dotfiles.git $DOTLOC

# Link required files
for file in zshrc vimrc tmux.conf gitconfig eslintrc; do
  rm ~/.$file
  ln -s $DOTLOC/$file ~/.file
done

ln -s gitignore-macos ~/.gitignore

# Install iStats for battery stats
gem install iStats

# Install global node modules
npm install --global babel-eslint eslint eslint-config-prettier eslint-config-react eslint-plugin-prettier np npm prettier
