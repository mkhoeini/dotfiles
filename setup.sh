#!/usr/bin/env zsh
set -euo pipefail

if ! command -v brew >/dev/null; then
    echo "Installing HomeBrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v emacs >/dev/null; then
    echo "Installing Emacs"
    brew tap d12frosted/emacs-plus
    brew install emacs-plus@29 --with-native-comp --with-modern-vscode-icon --with-xwidgets --with-imagemagick --with-poll --with-no-frame-refocus
fi

if [[ ! -e ~/.emacs.d ]]; then
    echo "Installing Spacemacs";
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d;
fi

defaults write -g ApplePressAndHoldEnabled -bool false

while read -r tap || [[ -n "$tap" ]]; do
  brew tap "$tap";
done <<< $tap_list
while read -r formula || [[ -n "$formula" ]]; do
  brew install "$formula";
done <<< $formula_list
while read -r cask || [[ -n "$cask" ]]; do
  brew install --cask "$cask";
done <<< $cask_list

stow -t $HOME home_links
