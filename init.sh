#!/bin/sh

# Install HomeBrew
if ! command -v brew >/dev/null; then
    echo "Installing HomeBrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Emacs
if ! command -v emacs >/dev/null; then
    echo "Installing Emacs"
    brew tap d12frosted/emacs-plus
    brew install emacs-plus@29 --with-native-comp --with-modern-vscode-icon --with-xwidgets --with-imagemagick --with-poll --with-no-frame-refocus
fi

home_links/.local/bin/run_org README.org tldr
