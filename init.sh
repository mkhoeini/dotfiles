#!/usr/bin/env sh
if ! command -v brew >/dev/null; then
  echo "Installing HomeBrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v just >/dev/null; then
  echo "Installing Just"
  brew install just
fi

just install
