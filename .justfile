
# List available commands
default:
  just --list

ZSHFILES := ".zshrc .zprofile"

# Install all dot files and dependencies
install: brew-install
  #!/usr/bin/env zsh
  set -euo pipefail
  for i in {{ZSHFILES}}; do
    ORIG=$PWD/$i
    LINK=$HOME/$i

    just _link "$ORIG" "$LINK"
  done

BREW_TAPS := "clementtsang/bottom"
BREW_DEPS := "
  antigen google-cloud-sdk fd bat lsd exa sk procs zoxide fzf
  clementtsang/bottom/bottom watchexec zsh git
"

# Install HomeBrew dependencies
brew-install:
  #!/usr/bin/env zsh
  set -euo pipefail
  for tap in {{BREW_TAPS}}; do
    brew tap $tap
  done
  for i in {{BREW_DEPS}}; do
    if brew list "$i" &>/dev/null || brew list --cask "$i" &>/dev/null; then
      echo "$i is already installed. skipping."
    else
      brew install "$i"
    fi
  done

_link ORIG LINK:
  #!/usr/bin/env zsh
  set -euo pipefail
  if [ -e "{{LINK}}" ]; then
    if [ "{{ORIG}}" -ef "{{LINK}}" ]; then
      echo "{{LINK}} is already linked. Skipping." 
    else
      echo "Another '{{LINK}}' exists. Skipping." 
    fi
  else
    ln -s "{{ORIG}}" "{{LINK}}"
    echo "Linked '{{LINK}}'"
  fi
