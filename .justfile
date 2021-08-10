
# List available commands
default:
  just --list

ZSHFILES := ".zshrc"

# Install all dot files
install:
  #!/usr/bin/env zsh
  for i in {{ZSHFILES}}; do
    ORIG=$PWD/$i
    LINK=$HOME/$i

    just _link "$ORIG" "$LINK"
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
