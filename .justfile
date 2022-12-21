
# List available commands
default:
  just --list

# Install all dot files and dependencies
install: brew-install
  #!/usr/bin/env zsh
  set -euo pipefail
  stow -t $HOME home_links

BREW_DEPS := " \
  antigen google-cloud-sdk fd bat lsd exa sk procs zoxide fzf lazygit \
  watchexec zsh git starship cowsay lolcat ponysay gnu-sed ranger \
  clementtsang/bottom/bottom tnk-studio/tools/lazykube asdf hyperfine \
  mkhoeini/tap/fortune-mod neovide oven-sh/bun/bun stow zellij \
"

# Install HomeBrew dependencies
brew-install:
  #!/usr/bin/env zsh
  set -euo pipefail
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
