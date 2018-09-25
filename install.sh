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

if [[ $os == 'android' ]]; then
  echo -n "=> Installing Packages..." 
  apt-get upgrade -y > /dev/null
  for tool in aria2 coreutils dnsutils git hub man openssh p7zip python tar tree unrar vim-python zsh
  do
    apt-get install $tool -y > /dev/null
  done
  termux-reload-settings
  echo "Done"
fi

echo -n "=> Cloning dotfiles..."
# create dotfiles directory and clone
mkdir -p $DOTLOC
git clone -q https://github.com/mohitsinghs/dotfiles.git $DOTLOC
echo "Done"

if [[ $os == 'mac' ]]; then
  echo -n "=> Installing homebrew..."
  # install homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "Done"
  echo -n "=> Installing packages..."
  # install packages
  brew bundle install --file=$DOTLOC/Brewfile > /dev/null
  # install iStats for battery stats
  gem install iStats > /dev/null
  echo "Done"
fi

echo -n "=> Linking Files..."
# link required files
for file in zshrc zshenv vimrc gitconfig gitignore
do
  rm ~/.$file &> /dev/null
  ln -s $DOTLOC/$file ~/.$file
done
echo "Done"

# change default shell to zsh
chsh -s zsh

if [[ $os == 'android' ]]; then
  echo -n "=> Installing pip and youtube-dl..."
  # upgrade pip and install youtube-dl
  pip install -q --upgrade pip
  pip install -q youtube-dl
  echo "Done"
  echo -n "=> Installing autosuggestion..."
  # install syntax highlighing and autosuggestions
  mkdir -p ~/.zsh
  git clone -q $ZSH_USERS/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  echo "Done"
  echo -n "=> Installing syntax-highlighting..."
  git clone -q $ZSH_USERS/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
  echo "Done"
fi

echo -n "=> Installing prompt..."
# install pure prompt
curl https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh --create-dirs -fsSLo $FUNPATH/prompt_pure_setup
curl https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh -fsSLo $FUNPATH/async
chmod +x $FUNPATH/prompt_pure_setup
chmod +x $FUNPATH/async
echo "Done"

# reload shell
exec zsh
termux-reload-settings

