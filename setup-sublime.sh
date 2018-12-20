#!/usr/bin/env zsh

# Sublime is still faster, and I have
# customized it to enable following features -
# 
# - Uses the same typings as vscode
# - Modern JavaScript and React Syntax
# - An easy to eye custom theme
# - A bunch of other plugins
# 
# Not everybody gonna love my setup so, I have organized
# them all in a private gitlab organisation
#
#   https://gitlab.com/mysublime
#
# Anyone with access to that org can grab my setup by running this script

set -e

doing () {
  echo -n "\\033[33m ➜ \\033[0m $1"
}

success () {
  echo -n "\\033[32m ✔ \\033[0m $1"
}

doing "Do you have Sublime Text installed (y/n) ? "
read installed
if [[ ! $installed =~ ^[Yy]$  ]]; then
  doing "Installing Sublime Text...\\n"
  # download Sublime Text 3
  wget  -nv --show-progress "https://download.sublimetext.com/Sublime Text Build 3176.dmg"
  # Mount disk image
  hdiutil attach "Sublime Text Build 3176.dmg"
  # Copy Application
  cp -r "/Volumes/Sublime Text/Sublime Text.app" "/Applications/Sublime Text.app"
  # Eject disk image
  hdiutil eject "/Volumes/Sublime Text"
  rm "Sublime Text Build 3176.dmg"
  success "Sublime Text installed"
fi

doing "Do you have access to \\033[36mgitlab.com/mysublime\\033[0m (y/n) ? "
read canaccess
if [[ $canaccess =~ ^[Yy]$ ]]; then
  # clone setup repo
  git clone -q git@gitlab.com:mysublime/setup.git $HOME/setup
  # run install script
  $HOME/setup/install.sh
  # remove setup repo
  rm -rf $HOME/setup
else
  echo -n "\\033[31m ✖ \\033[0m Sorry, You need access for setting up."
  exit 1
fi
