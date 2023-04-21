#!/usr/bin/env ruby
tap_list = <<HEREDOC.gsub(/;.*$/, '').split("\n").map(&:strip).reject(&:empty?)
  borkdude/brew ; babashka
  ;; bufbuild/buf
  homebrew/cask-drivers ; device drivers
  homebrew/cask-fonts
  homebrew/cask-versions
  ;homebrew/command-not-found ; It's very slow. Don't use it
  mkhoeini/tap ; fortune-mod
  ;oven-sh/bun ; bun.sh
  remotemobprogramming/brew
  ;; spotify/public
  ;tnk-studio/tools ; lazykube
HEREDOC

formula_list = <<HEREDOC.gsub(/;.*$/, '').split("\n").map(&:strip).reject(&:empty?)
  ;; adns
  antigen ; ZSH plugin management. TODO replace with antidote
  ;; aom
  ;; asciinema
  asdf ; tools version management
  ;; assimp
  babashka ; clojure cli scripting
  bat ; better cat alternative
  ;; bdw-gc
  ;; berkeley-db
  ;; bison
  ;; black
  ;; boost
  bottom ; better top util
  ;; brotli
  ;bun ; node.js alternative
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
  exa ; better ls alternative
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
  fortune-mod ; beautiful quotes in the terminal. TODO include more quotes
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
  hub ; convenient github cli. TODO add configs
  ;; hunspell
  hyperfine ; terminal benchmark util
  ;; icu4c
  ijq ; interactive jq for json manipulation
  ;; ilmbase
  ;; imagemagick
  ;; imath
  ;; ipython
  ;; isl
  ;; ispell
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
  ;lazygit ; git TUI
  ;; lazykube
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
  ;; luarocks
  ;; luv
  ;; lz4
  ;; lzo
  ;; m4
  ;; make
  maven ; java package manager
  ;; mbedtls
  ;; md4c
  ;; mitmproxy
  mob ; mob cli for mobbing
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
  starship ; zsh prompt. TODO replace with powerlevel10k
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
  ;; z
  ;; z3
  zellij ; better tmux alternative
  ;; zeromq
  ;; zimg
  ;; zlib
  zoxide ; better cd alternative. z command
  zsh
  ;; zstd
HEREDOC

cask_list = <<HEREDOC.gsub(/;.*$/, '').split("\n").map(&:strip).reject(&:empty?)
  alacritty ; terminal emulator
  ;blurred ; dim background apps windows
  browserosaurus ; select which browser. TODO replace with hammerspoon
  chromium
  coconutbattery ; battery info util
  ;; corretto
  ;; corretto8
  diffusionbee ; Stable Diffusion mac image tool
  ;docker ; docker desktop. Uses correct arch
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
  hammerspoon ; desktop automation tool. TODO configs
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
  rancher ; Docker Desktop replacement
  rectangle ; TODO migrate to hammerspoon
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
HEREDOC

installed_taps = `brew tap`
tap_list
  .reject { |tap| installed_taps.include? tap }
  .each { |tap| `brew tap "#{tap}"` }

installed_formulas = `brew list --formula`
formula_list
  .reject { |formula| installed_formulas.include? formula }
  .each { |formula| `brew install "#{formula}"` }

installed_casks = `brew list --cask`
cask_list
  .reject { |cask| installed_casks.include? cask }
  .each { |cask| `brew install --cask "#{cask}"` }

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
