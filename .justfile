
# List available commands
default:
  just --list

ZSHFILES := `find home_links -type f | cut -c 12-`

# Install all dot files and dependencies
install: brew-install
  #!/usr/bin/env zsh
  set -euo pipefail
  ZSHFILES="{{ZSHFILES}}"
  echo $ZSHFILES | while read i; do
    ORIG="$PWD/home_links/$i"
    LINK="$HOME/$i"

    just _link "$ORIG" "$LINK"
  done

BREW_TAPS := "mkhoeini/tap clementtsang/bottom"
BREW_DEPS := " \
  antigen google-cloud-sdk fd bat lsd exa sk procs zoxide fzf bottom \
  watchexec zsh git starship fortune cowsay lolcat ponysay \
"

# Install HomeBrew dependencies
brew-install:
  #!/usr/bin/env zsh
  set -euo pipefail
  taps=$(brew tap)
  for tap in {{BREW_TAPS}}; do
    if [[ "$taps" == *"$tap"* ]]; then
      echo "$tap is already tapped. skipping."
    else
      brew tap $tap
    fi
  done
  formulas=$(brew list --formula)
  casks=$(brew list --cask)
  for dep in {{BREW_DEPS}}; do
    if [[ "$formulas" == *"$dep"* ]] || [[ "$casks" == *"$dep"* ]]; then
      echo "$dep already installed. skipping."
    else
      brew install "$dep"
    fi
  done

_link ORIG LINK:
  #!/usr/bin/env zsh
  set -euo pipefail
  if [ -e "{{LINK}}" ] || [ -L "{{LINK}}" ]; then
    if [ "{{ORIG}}" -ef "{{LINK}}" ]; then
      echo "{{LINK}} is already linked. Skipping." 
    else
      echo "Another '{{LINK}}' exists. Skipping." 
    fi
  else
    LINK="{{LINK}}"
    mkdir -p "${LINK:h}"
    ln -s "{{ORIG}}" "{{LINK}}"
    echo "Linked '{{LINK}}'"
  fi
