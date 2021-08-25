
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

BREW_DEPS := " \
  antigen google-cloud-sdk fd bat lsd exa sk procs zoxide fzf \
  watchexec zsh git starship cowsay lolcat ponysay \
  clementtsang/bottom/bottom \
  mkhoeini/tap/fortune-mod mkhoeini/tap/neovide \
"

# Install HomeBrew dependencies
brew-install:
  #!/usr/bin/env zsh
  set -euo pipefail
  taps=$(brew tap)
  formulas=$(brew list --formula)
  casks=$(brew list --cask)
  for dep in {{BREW_DEPS}}; do
    depname=$(echo "$dep" | rev | cut -d/ -f1 | rev)
    if [[ "$formulas" == *"$depname"* ]] || [[ "$casks" == *"$depname"* ]]; then
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
