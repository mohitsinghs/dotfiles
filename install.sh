#!/bin/bash

# detect os
os='unknown'
if [[ $(uname -o) == 'Android' ]]; then
  os='android'
elif [[ $(uname) == 'Darwin' ]]; then
  os='mac'
elif [[ $(uname) == 'Linux' ]]; then
  os='linux'
fi

# define variables
DOTLOC=~/Projects/dotfiles
ZSH_USERS=https://github.com/zsh-users
FUNPATH=/usr/local/share/zsh/site-functions
if [[ $os == 'android' ]]; then
  FUNPATH=/data/data/com.termux/files/usr/share/zsh/site-functions
fi

# No help from next launch
touch ~/.hushlogin

# create dotfiles directory
mkdir -p $DOTLOC

if [[ $os == 'mac' ]]; then
  # install homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  # install packages
  brew bundle install $DOTLOC/Brewfile
  # install iStats for battery stats
  gem install iStats
elif [[ $os == 'android' ]]; then
  pkg upgrade -y
  for tool in aria2 coreutils dnsutils git hub man nodejs openssh p7zip python tree unrar vim-python zip zsh 
  do
    pkg install $tool -y
  done
  termux-reload-settings
fi

# clone and link required files
git clone https://github.com/mohitsinghs/dotfiles.git $DOTLOC
for file in zshrc zshenv vimrc gitconfig gitignore
do
  rm ~/.$file &> /dev/null
  ln -s $DOTLOC/$file ~/.$file
done

# change default shell to zsh
chsh -s zsh

if [[ $os == 'android' ]]; then
  # upgrade pip and install youtube-dl
  pip install --upgrade pip
  pip install youtube-dl
  # install syntax highlighing and autosuggestions
  mkdir -p ~/.zsh
  git clone $ZSH_USERS/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  git clone $ZSH_USERS/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
  # Fix a bug which prevents npm from updating
  sed -ie "s/require('os').cpus().length/1/g" ~/../usr/lib/node_modules/npm/node_modules/worker-farm/lib/farm.js
fi

# Install global node modules
npm i -g np npm serve surge standard babel-eslint prettier

# install pure prompt
curl https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh --create-dirs -fLo $FUNPATH/prompt_pure_setup
curl https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh -fLo $FUNPATH/async
chmod +x $FUNPATH/prompt_pure_setup
chmod +x $FUNPATH/async
# reload shell
exec zsh

