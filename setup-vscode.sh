#!/usr/bin/env zsh

# VSCode is full of features but there are some drawbacks of it.
# Due to these drawbacks, I keep Sublime installed along with it.
# Following are those drawbacks
# 
# - Eats battery due to being an electron app
# - Font rendering is not as pleasant as Sublime
# - Slower than sublime for some tasks
#
# Just run this script to get everything setup

set -e

echo -n "Do you have VSCode installed (y/n)? "
read answer
if [[ ! "$answer" != "${answer#[Yy]}" ]]; then
  # get the latest VSCode
  wget "https://update.code.visualstudio.com/latest/darwin/stable"
  # unzip it
  unzip stable
  # copy to Applications
  mv "Visual Studio Code.app" "/Applications/Visual Studio Code.app"
  # remove archive
  rm stable
  ln -s '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code' '/usr/local/bin'
fi

# Install vscode extensions
echo -n "=> Installing VSCode extensions..."
plugins=( \
  alefragnani.project-manager \
  be5invis.vscode-custom-css \
  chenxsan.vscode-standardjs \
  christian-kohler.npm-intellisense \
  christian-kohler.path-intellisense \
  CoenraadS.bracket-pair-colorizer-2 \
  EditorConfig.EditorConfig \
  esbenp.prettier-vscode \
  jpoissonnier.vscode-styled-components \
  ms-python.python \
  msjsdiag.debugger-for-chrome \
  naumovs.color-highlight \
  octref.vetur \
  sdras.night-owl \
  wayou.vscode-todo-highlight \
)
for plugin in $plugins;
do
  code --install-extension $plugin
done
echo "Done"

# Link settings
VSUSR="$HOME/Library/Application Support/Code/User"
echo -n "=> Linking settings.json..."
if [[ -f $VSUSR/settings.json ]]; then
  rm $VSUSR/settings.json
fi
ln -s "$HOME/Projects/dotfiles/settings.json" $VSUSR/settings.json
echo "Done"
