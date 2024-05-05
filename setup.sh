#!/usr/bin/env zsh
set -euxo pipefail

# I forgot the password! ':)
# eval "$(gpg --decrypt secrets.sh.gpg)"

if ! command -v brew >/dev/null; then
    echo "Installing HomeBrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v emacs >/dev/null; then
    echo "Installing Emacs"
    brew tap d12frosted/emacs-plus
    brew install emacs-plus@30 --with-native-comp --with-modern-vscode-icon --with-xwidgets --with-imagemagick --with-poll --with-no-frame-refocus
fi

if ! command -v stow >/dev/null; then
    echo "Installing GNU Stow"
    brew install stow
fi

stow -t $HOME home_links

if [[ ! -e ~/dotemacs/doom ]]; then
    echo "Installing Doom Emacs";
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/dotemacs/doom;
fi

if [[ ! -e ~/.config/nvim ]]; then
    echo "Installing LazyVim";
    git clone https://github.com/LazyVim/starter ~/.config/nvim;
fi

if [[ ! -e ~/.intellimacs ]]; then
    echo "Installing Intellimacs";
    git clone https://github.com/MarcoIeni/intellimacs ~/.intellimacs;
fi

defaults write -g ApplePressAndHoldEnabled -bool false

./setup.rb
