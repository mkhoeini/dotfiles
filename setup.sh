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

if ! command -v stow >/dev/null; then
    echo "Installing GNU Stow"
    brew install stow
fi

stow -t $HOME home_links

if [[ ! -e ~/.emacs.d ]]; then
    echo "Installing Spacemacs";
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d;
fi

defaults write -g ApplePressAndHoldEnabled -bool false

./setup.rb
