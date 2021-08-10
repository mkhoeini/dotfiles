
# List available commands
default:
  just --list

ZSHFILES := ".zshrc"

# Install all dot files
install: brew-install
  #!/usr/bin/env zsh
  for i in {{ZSHFILES}}; do
    ORIG=$PWD/$i
    LINK=$HOME/$i

    just _link "$ORIG" "$LINK"
  done

BREW_DEPS := "antigen"

# Install HomeBrew dependencies
brew-install:
  #!/usr/bin/env zsh
  for i in {{BREW_DEPS}}; do
    if brew list "$i" >/dev/null; then
      echo "$i is already installed. skipping."
    else
      brew install "$i"
    fi
  done

_link ORIG LINK:
  #!/usr/bin/env zsh
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
