
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

_emacs_install:
  #!/usr/bin/env zsh
  brew install d12frosted/emacs-plus/emacs-plus@29 --with-native-comp --with-modern-vscode-icon --with-xwidgets --with-imagemagick --with-poll --with-no-frame-refocus

# Install HomeBrew dependencies
brew-install: _emacs_install
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
