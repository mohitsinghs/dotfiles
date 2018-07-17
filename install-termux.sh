#!/bin/sh

# No help from next launch
touch ~/.hushlogin

# Install required packages
for tool in aria2 coreutils dnsutils git hub man mp3splt nodejs openssh p7zip python tree unrar vim zip zsh; do
  pkg install $tool -y
done

# unzip some private files from sdcard to home directory
unzip /sdcard/secure.zip -d ~

termux-reload-settings

# Clone dotfiles
DOTLOC=~/Projects/dotfiles
mkdir -p $DOTLOC
git clone git@github.com:mohitsinghs/dotfiles.git $DOTLOC

# Link required files
for file in zshrc zshenv vimrc gitconfig; do
  rm ~/.$file
  ln -s $DOTLOC/$file ~/.$file
done

# change default shell to zsh
chsh -s zsh

# Upgrade pip and install youtube-dl
pip install --upgrade pip
pip install youtube-dl

# Insall pure prompt, syntax highlighing and autosuggestions
ZSH_USERS=https://github.com/zsh-users
git clone $ZSH_USERS/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone $ZSH_USERS/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
FUNPATH=/data/data/com.termux/files/usr/share/zsh/site-functions
mkdir -p $FUNPATH
curl https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh -o $FUNPATH/prompt_pure_setup
curl https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh -o $FUNPATH/async
chmod +x $FUNPATH/prompt_pure_setup
chmod +x $FUNPATH/async
