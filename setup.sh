#!/bin/sh
if ! command -v brew >/dev/null; then
    echo "Installing HomeBrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v emacs >/dev/null; then
    echo "Installing Emacs"
    brew tap d12frosted/emacs-plus
    brew install emacs-plus@29 --with-native-comp --with-modern-vscode-icon --with-xwidgets --with-imagemagick --with-poll --with-no-frame-refocus
fi

home_links/.local/bin/run_org README.org tldr

formula_list='antigen
asdf
babashka
bat
bottom
clojure
clojurescript
coreutils
cowsay
curlie
direnv
exa
fd
fortune-mod
fzf
git
git-gui
gnu-sed
hub
hyperfine
ijq
jq
lolcat
mob
neovide
neovim
ponysay
procs
ripgrep
rlwrap
starship
stow
watchexec
zellij
zoxide
zsh'
cask_list='alacritty
browserosaurus
coconutbattery
firefox
font-droidsansmono-nerd-font
font-iosevka-nerd-font
font-jetbrains-mono-nerd-font
font-juliamono
google-cloud-sdk
hammerspoon
iina
intellij-idea-ce
itsycal
telegram
tomatobar
vimr
visual-studio-code'
tap_list='borkdude/brew
homebrew/cask-drivers
homebrew/cask-fonts
homebrew/cask-versions
mkhoeini/tap
remotemobprogramming/brew'
while read -r tap || [[ -n "$tap" ]]; do
  brew tap "$tap";
done <<< $tap_list
while read -r formula || [[ -n "$formula" ]]; do
  brew install "$formula";
done <<< $formula_list
while read -r cask || [[ -n "$cask" ]]; do
  brew install --cask "$cask";
done <<< $cask_list

if [[ ! -e ~/.emacs.d ]]; then
    echo "Installing Spacemacs";
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d;
fi

stow -t $HOME home_links
