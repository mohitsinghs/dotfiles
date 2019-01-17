#!/usr/bin/env bash
set -e

doing () {
  printf "\\033[33m ➜ \\033[0m $1"
}

success () {
  printf "\\033[32m ✔ \\033[0m\\n"
}

fail () {
  printf "\\n\\033[31m ✖ \\033[0m $1\\n"
  exit 1
}

# exit if macos is not found
doing "Checking system..."
if [[ $(uname) != 'Darwin' ]]; then
  fail "You are not on a mac."
else
  success
fi

doing "Looking for VSCode..."
if [[ -d "/Applications/Visual Studio Code.app" ]]; then
  fail "VSCode is already installed"
else
  success
  doing "Installing latest VSCode..."
  echo
  # get the latest VSCode
  wget -q --show-progress "https://update.code.visualstudio.com/latest/darwin/stable"
  # move cursor to end of previous line
  printf "\\033[2A\\033[31C\\033[J"
  # unzip it
  unzip stable >/dev/null
  # copy to Applications
  mv "Visual Studio Code.app" "/Applications/Visual Studio Code.app"
  # remove downloaded file  
  rm stable
  success
fi

if [[ ! -h "/usr/local/bin/code" ]]; then
  doing "Linking \\033[36m code \\033[0m binary..."
  ln -s "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" "/usr/local/bin"
  success
fi

# Install vscode extensions
doing "Installing VSCode extensions..."
plugins=( \
  alefragnani.project-manager \
  be5invis.vscode-custom-css \
  chenxsan.vscode-standardjs \
  christian-kohler.npm-intellisense \
  christian-kohler.path-intellisense\
  CoenraadS.bracket-pair-colorizer-2 \
  eamodio.gitlens \
  EditorConfig.EditorConfig \
  GitHub.vscode-pull-request-github \
  esbenp.prettier-vscode \
  jpoissonnier.vscode-styled-components \
  ms-python.python \
  msjsdiag.debugger-for-chrome \
  naumovs.color-highlight \
  octref.vetur \
  ronnidc.nunjucks \
  sdras.night-owl \
  wayou.vscode-todo-highlight \
)
echo
for plugin in ${plugins[*]};
do
  printf "\\033[2m      Installing %s\\033[0m" "$plugin"
  code --install-extension "$plugin" >/dev/null
  # clear current line
  printf "\\r\\033[K"
done
# move cursor to end of previous line
printf "\\033[1A\\033[35C"
success

# Link settings
doing "Linking VSCode settings..."
VSUSR="$HOME/Library/Application Support/Code/User"
if [[ -a $VSUSR/settings.json ]]; then
  rm "$VSUSR/settings.json"
fi
ln -s "$HOME/Projects/dotfiles/settings.json" "$VSUSR/settings.json"
success
