#!/usr/bin/env ruby
# frozen_string_literal: true

# check if program installed
def exec?(cmd)
  system("command -v #{cmd} >/dev/null")
end

unless exec?('brew')
  puts 'Installing HomeBrew'
  system 'bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
end

unless exec?('emacs')
  puts 'Installing Emacs'
  system 'brew install d12frosted/emacs-plus/emacs-plus@30 ' \
         '--with-native-comp --with-modern-vscode-icon --with-xwidgets ' \
         '--with-imagemagick --with-compress-install --with-no-frame-refocus'
end

unless exec?('stow')
  puts 'Installing GNU Stow'
  system 'brew install stow'
end

puts 'Linking dotfiles'
system 'stow -t $HOME home_links'

unless File.exist?(File.expand_path('~/dotemacs/doom'))
  puts 'Installing Doom Emacs'
  system 'git clone --depth 1 https://github.com/doomemacs/doomemacs ~/dotemacs/doom'
  system 'ln -s ~/dotemacs/doom ~/.emacs.d'
  system 'brew services restart d12frosted/emacs-plus/emacs-plus@30'
end

unless File.exist?(File.expand_path('~/.config/nvim'))
  puts 'Installing LazyVim'
  system 'git clone https://github.com/LazyVim/starter ~/.config/nvim'
end

unless File.exist?(File.expand_path('~/.intellimacs'))
  puts 'Installing Intellimacs'
  system 'git clone https://github.com/MarcoIeni/intellimacs ~/.intellimacs'
end

MACOS_DEFAULTS = {
  # Enable repeat keys
  ApplePressAndHoldEnabled: '-bool false',

  # opening and closing windows and popovers
  NSAutomaticWindowAnimationsEnabled: '-bool false',

  # smooth scrolling
  NSScrollAnimationEnabled: '-bool false',

  # showing and hiding sheets, resizing preference windows, zooming windows
  # float 0 doesn't work
  NSWindowResizeTime: '-float 0.001',

  # opening and closing Quick Look windows
  QLPanelAnimationDuration: '-float 0',

  # rubberband scrolling (doesn't affect web views)
  NSScrollViewRubberbanding: '-bool false',

  # resizing windows before and after showing the version browser
  # also disabled by NSWindowResizeTime -float 0.001
  NSDocumentRevisionsWindowTransformAnimation: '-bool false',

  # showing a toolbar or menu bar in full screen
  NSToolbarFullScreenAnimationDuration: '-float 0',

  # scrolling column views
  NSBrowserColumnAnimationSpeedMultiplier: '-float 0'
}.freeze

# TODO: app defaults
# showing the Dock
# defaults write com.apple.dock autohide-time-modifier -float 0
# defaults write com.apple.dock autohide-delay -float 0

# showing and hiding Mission Control, command+numbers
# defaults write com.apple.dock expose-animation-duration -float 0

# showing and hiding Launchpad
# defaults write com.apple.dock springboard-show-duration -float 0
# defaults write com.apple.dock springboard-hide-duration -float 0

# changing pages in Launchpad
# defaults write com.apple.dock springboard-page-duration -float 0

# at least AnimateInfoPanes
# defaults write com.apple.finder DisableAllAnimations -bool true

# sending messages and opening windows for replies
# defaults write com.apple.Mail DisableSendAnimations -bool true
# defaults write com.apple.Mail DisableReplyAnimations -bool true

MACOS_DEFAULTS.each_pair do |opt, val|
  system "defaults write -g #{opt} #{val}"
end

formula_list = <<HEREDOC.gsub(/;.*$/, '').split("\n").map(&:strip).reject(&:empty?)
  ;; adns
  nikitabobko/tap/aerospace
  antidote ; ZSH plugin manager.
  ;antigen ; ZSH plugin management. outdated. use antidote instead
  ;; aom
  ;; asciinema
  asdf ; tools version management
  ;; assimp
  borkdude/brew/babashka ; clojure cli scripting
  bat ; better cat alternative
  ;; bdw-gc
  ;; berkeley-db
  ;; bison
  ;; black
  ;; boost
  bottom ; better top util
  ;; brotli
  oven-sh/bun/bun ; node.js alternative
  ;; burklee
  ;; bzip2
  ;; c-ares
  ;; ca-certificates
  ;; cjson
  clojure
  clojurescript
  ;; cmake
  ;; cmocka
  ;; concurrencykit
  coreutils
  cowsay ; terminal eye candy
  ;; ctags
  curlie ; better curl alternative
  ;; dav1d
  ;; dbus
  ;; deno
  ;; desktop-file-utils
  direnv
  ;; docbook
  ;; docbook-xsl
  ;; double-conversion
  ;; doxygen
  dust ; better du alternative for measuring dir size
  ;; ebook-tools
  ;; edencommon
  ;; entr
  eza ; better ls alternative
  ;; exiv2
  ;; extra-cmake-modules
  ;; fasd
  ;; fb303
  ;; fbthrift
  fd ; better find util
  ;; ffmpeg
  ;; fizz
  ;; flac
  ;; flex
  ;; flyway
  ;; fmt
  ;; folly
  ;; fontconfig
  mkhoeini/tap/fortune-mod ; beautiful quotes in the terminal. TODO include more quotes
  ;; freetype
  ;; frei0r
  ;; fribidi
  ;; fx
  fzf ; fuzzy search util
  ;; fzy
  ;; gcc
  ;; gd
  ;; gdbm
  ;; gdk-pixbuf
  ;; gettext
  ;; gflags
  ;; gh
  ;; ghc
  ;; ghostscript
  ;; giflib
  git ; version control system
  git-delta ; show beautiful git diffs in terminal
  git-gui ; gitx and git gui commands
  ;; glib
  ;; glog
  glow ; Beautiful Terminal Markdown Renderer
  ;; gmp
  ;; gnu-getopt
  gnu-sed ; standard sed util implementation
  ;; gnu-tar
  ;; gnupg
  ;; gnutls
  ;; go
  ;; gobject-introspection
  ;; gperf
  ;; gpgme
  ;; graphite2
  ;; graphviz
  ;; grpcurl
  ;; gts
  ;; guile
  ;; hades-cli
  ;; harfbuzz
  ;; highway
  ;; hmtools
  ;hub ; convenient github cli
  ;; hunspell
  hyperfine ; terminal benchmark util
  ;; icu4c
  ijq ; interactive jq for json manipulation
  ;; ilmbase
  ;; imagemagick
  ;; imath
  ;; ipython
  ;; isl
  ispell ; emacs uses this for spell checking
  ;; jansson
  ;; jasper
  ;; jbig2dec
  ;; jemalloc
  ;; jet
  ;; jlog
  ;; jpeg
  ;; jpeg-turbo
  ;; jpeg-xl
  jq ; commandline json util
  ;just ; better make alternative
  ;; k6
  ;; kde-extra-cmake-modules
  ;; kf5-kdoctools
  ;; krb5
  ;; kubectl-site
  ;; kubectx
  ;; kubernetes-cli
  ;; lame
  lazygit ; git TUI
  ;tnk-studio/tools/lazykube ; kubernetes cli
  ;; leiningen
  ;; leptonica
  ;; libarchive
  ;; libass
  ;; libassuan
  ;; libavif
  ;; libb2
  ;; libbluray
  ;; libcanberra
  ;; libcbor
  ;; libcroco
  ;; libde265
  ;; libepoxy
  ;; libev
  ;; libevent
  ;; libffi
  ;; libfido2
  ;; libgccjit
  ;; libgcrypt
  ;; libgpg-error
  ;; libheif
  ;; libidn
  ;; libidn2
  ;; libksba
  ;; liblinear
  ;; liblqr
  ;; libmng
  ;; libmpc
  ;; libmtp
  ;; libnghttp2
  ;; libogg
  ;; libomp
  ;; libpng
  ;; libproxy
  ;; libpthread-stubs
  ;; libraw
  ;; librist
  ;; librsvg
  ;; libsamplerate
  ;; libsndfile
  ;; libsodium
  ;; libsoxr
  ;; libssh
  ;; libssh2
  ;; libtasn1
  ;; libtermkey
  ;; libtiff
  ;; libtool
  ;; libunistring
  ;; libusb
  ;; libusb-compat
  ;; libuv
  ;; libvidstab
  ;; libvmaf
  ;; libvorbis
  ;; libvpx
  ;; libvterm
  ;; libx11
  ;; libxau
  ;; libxcb
  ;; libxdmcp
  ;; libxext
  ;; libxml2
  ;; libxrender
  ;; libxslt
  ;; libyaml
  ;; libzip
  ;; little-cms2
  ;; llvm
  lolcat ; make terminal quotes colorful
  ;; lua
  ;; lua@5.3
  ;; luajit
  ;; luajit-openresty
  luarocks ; package management for lua
  ;; luv
  ;; lz4
  ;; lzo
  ;; m4
  ;; make
  maven ; java package manager
  ;; mbedtls
  ;; md4c
  ;; mitmproxy
  remotemobprogramming/brew/mob ; mob cli for mobbing
  ;; mosh
  ;; mpdecimal
  ;; mpfr
  ;; msgpack
  ;; mysql
  ;; ncurses
  neovide ; GUI for neovim
  neovim ; better vim alternative
  ;; netpbm
  ;; nettle
  ;; nghttp2
  ;; ninja
  ;; nmap
  ;; npth
  ;; nspr
  ;; nss
  ;; oha
  ;; onefetch
  ;; oniguruma
  ;; opencore-amr
  ;; openexr
  ;; openjpeg
  ;; openslp
  ;; openssl@1.1
  ;; opus
  ;; p11-kit
  p7zip ; 7zip compression with new extentions
  ;; pandoc
  ;; pango
  ;; parallel
  ;; pcre
  ;; pcre2
  ;; perl
  ;; pgweb
  ;; pinentry
  ;; pixman
  ;; pkg-config
  ponysay ; cowsay alternative
  ;; poppler
  ;; postgresql
  ;; postgresql@13
  ;; postgresql@14
  ;; prettyping
  procs ; better ps alternative
  ;; protobuf
  ;; pygments
  ;ranger ; terminal file manager
  ;; rav1e
  ;; readline
  ;; recode
  ripgrep ; cli search util
  rlwrap ; readline cli util
  ;; rtmpdump
  ;; rubberband
  ;; rust
  ;; sbt
  ;; scala
  ;; scc
  ;; scio
  ;; sdl2
  ;; shared-mime-info
  ;; shellcheck
  ;; showkey
  ;; six
  ;; snappy
  ;; speedtest-cli
  ;; speex
  ;; spgrpcurl
  ;; spotify-disco
  ;; spotify-nameless-cli
  ;; sqlite
  ;; srt
  ;starship ; zsh prompt. instead use powerlevel10k
  stow ; symlink management
  ;; styx-cli
  ;; taglib
  ;; tcl-tk
  ;; tesseract
  ;; texinfo
  ;; theora
  ;; tree-sitter
  triangle ; Convert images to triangulation art
  ;; ttyplot
  tinymist
  ;; unbound
  ;; unibilium
  ;; unixodbc
  ;; utf8proc
  ;; v2ray
  ;; wakatime-cli
  ;; wangle
  watchexec ; run commands on file change
  ;; watchman
  ;; webp
  ;; websocat
  ;; wget
  ;; x264
  ;; x265
  xdg-ninja ; Config dotfiles to be in XDG folders - TODO apply suggestions
  ;; xmlto
  ;; xorgproto
  ;; xvid
  ;; xz
  koekeishiya/formulae/yabai
  ;; z
  ;; z3
  ;zellij ; better tmux alternative
  ;; zeromq
  ;; zimg
  ;; zlib
  zoxide ; better cd alternative. z command
  zsh
  ;; zstd
HEREDOC

cask_list = <<HEREDOC.gsub(/;.*$/, '').split("\n").map(&:strip).reject(&:empty?)
  ;alacritty ; terminal emulator
  ;blurred ; dim background apps windows
  ;browserosaurus ; select which browser
  ;chromium
  coconutbattery ; battery info util
  ;; corretto
  ;; corretto8
  diffusionbee ; Stable Diffusion mac image tool
  docker ; docker desktop. Uses correct arch
  ;; edex-ui
  firefox
  flux ; set color temp at evening
  ;; font-code-new-roman-nerd-font
  ;; font-dejavu-sans-mono-nerd-font
  font-droid-sans-mono-nerd-font
  ;; font-fira-code-nerd-font
  ;; font-firacode-nerd-font
  ;; font-hack-nerd-font
  ;; font-hasklig
  ;; font-hasklig-nerd-font
  font-iosevka-nerd-font
  font-jetbrains-mono-nerd-font
  font-juliamono
  ;; font-lilex
  ;; font-monoid-nerd-font
  ;; font-noto-nerd-font
  font-roboto-mono-nerd-font ; used for alacritty
  ;; font-victor-mono-nerd-font
  ;; github-beta
  ;; google-chrome
  google-cloud-sdk ; cli for google cloud
  hammerspoon ; desktop automation tool
  hiddenbar ; make taskbar icons hidden
  iina ; greate video player
  intellij-idea-ce
  itsycal ; calendar menubar
  ;; kitty
  ;; lapce ; Rust based GUI editor
  logseq ; personal knowledge management
  ;; meetingbar
  ;; noisebuddy
  ;; noisy
  ;onething ; TODO doesn't exist - focus on one thing at a time
  ;; qutebrowser
  ;rancher ; Docker Desktop replacement
  raycast ; App Launcher
  ;rectangle ; Window management with keyboard
  ;; retinizer
  ;; spotify
  ;; swiftdefaultappsprefpane
  telegram
  ;; telegram-desktop ; electron based
  ;; todoist
  tomatobar ; pomodoro menubar
  tribler ; torrent download client
  ;vimac ; TODO doesn't exist - mac vim mode hints overlay
  vimr ; another vim GUI
  visual-studio-code
  ;; xbar ; menubar super app
  wezterm
  zed
HEREDOC

installed_formulas = `brew list --full-name`
formula_list
  .concat(cask_list)
  .reject { |formula| installed_formulas.include? formula }
  .each { |formula| `brew install "#{formula}"` }

requested_asdf_plugins = <<-HEREDOC.gsub(/;.*$/, '').strip.split(/\s+/)
  kotlin
  kscript
  java
  nodejs
  ruby
  rust
HEREDOC

installed_asdf_plugins = `asdf plugin list`
requested_asdf_plugins
  .reject { |plugin| installed_asdf_plugins.include? plugin }
  .each do |plugin|
  `asdf plugin add "#{plugin}"`
  `asdf install "#{plugin}" latest`
end

requested_luarocks_plugins = <<-HEREDOC.gsub(/;.*$/, '').strip.split(/\s+/)
  fennel
HEREDOC

installed_luarocks_plugins = `luarocks list --porcelain`
requested_luarocks_plugins
  .reject { |plugin| installed_luarocks_plugins.include? plugin }
  .each { |plugin| `luarocks install #{plugin}` }
