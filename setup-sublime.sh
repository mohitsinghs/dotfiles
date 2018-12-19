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

echo -n "Do you have Sublime Text installed (y/n)? "
read answer
if [[ ! "$answer" != "${answer#[Yy]}" ]]; then
  # download Sublime Text 3
  wget "https://download.sublimetext.com/Sublime Text Build 3176.dmg"
  # Mount disk image
  hdiutil attach "Sublime Text Build 3176.dmg"
  # Copy Application
  cp -r "/Volumes/Sublime Text/Sublime Text.app" "/Applications/Sublime Text.app"
  # Eject disk image
  hdiutil eject "/Volumes/Sublime Text"
  rm "Sublime Text Build 3176.dmg"
fi

# clone setup repo
g clone -q git@gitlab.com:mysublime/setup.git
# run install script
./setup/install.sh
# remove setup repo
rm -rf ./setup
