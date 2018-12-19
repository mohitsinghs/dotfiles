#!/bin/bash

# exit if macos is not found
if [[ $(uname) != 'Darwin' ]]; then
  echo "Sorry! found $(uname) instead of Darwin"
  exit 1
fi

# define variables
DOTLOC=~/Projects/dotfiles
ZSH_USERS=https://github.com/zsh-users
FUNPATH=/usr/local/share/zsh/site-functions

# No help from next launch
touch ~/.hushlogin

echo -n "=> Cloning dotfiles..."
# cleanup dotfiles directory
[[ -d $DOTLOC ]] && rm -rf $DOTLOC
# create dotfiles directory and clone
mkdir -p $DOTLOC
git clone -q https://github.com/mohitsinghs/dotfiles.git $DOTLOC
echo "Done"

# install homebrew if missing
if [[ ! -x "$(command -v brew)" ]]; then
  echo -n "=> Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "Done"
fi

echo -n "=> Installing packages..."
# install packages
brew bundle install --file=$DOTLOC/Brewfile > /dev/null
# install iStats for battery stats
gem install iStats > /dev/null
echo "Done"

echo -n "=> Linking Files..."
# link required files
for file in zshrc zshenv gitconfig gitignore
do
  rm ~/.$file &> /dev/null
  ln -s $DOTLOC/$file ~/.$file
done
echo "Done"

# change default shell to zsh
chsh -s zsh

echo -n "=> Installing prompt..."
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
echo "Done"

# reload shell
exec zsh
