#!/usr/bin/env zsh
set -euxo pipefail

# get the secrets
eval "$(gpg --decrypt secrets.sh.gpg)"

# run the ruby setup
./setup.rb
