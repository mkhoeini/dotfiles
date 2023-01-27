#!/usr/bin/env ruby
<<HEREDOC.gsub(/;.*$/, '').strip.split(/\s+/)
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

tap_list=["borkdude/brew", "homebrew/cask-drivers", "homebrew/cask-fonts", "homebrew/cask-versions", "mkhoeini/tap", "remotemobprogramming/brew"]
installed = `brew tap`
tap_list.reject { |tap| installed.include? tap }

<<HEREDOC.gsub(/;.*$/, '').strip.split(/\s+/)
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
  ;; git-delta ; TODO add the configs
  git-gui ; gitx and git gui commands
  ;; glib
  ;; glog
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

formula_list=["antigen", "asdf", "babashka", "bat", "bottom", "clojure", "clojurescript", "coreutils", "cowsay", "curlie", "direnv", "dust", "exa", "fd", "fortune-mod", "fzf", "git", "git-gui", "gnu-sed", "hub", "hyperfine", "ijq", "jq", "lolcat", "maven", "mob", "neovide", "neovim", "ponysay", "procs", "ripgrep", "rlwrap", "starship", "stow", "watchexec", "zellij", "zoxide", "zsh"]
installed = `brew list --formula`
formula_list.reject { |formula| installed.include? formula }

<<HEREDOC.gsub(/;.*$/, '').split(/\s+/)
  alacritty ; terminal emulator
  ;blurred ; dim background apps windows
  browserosaurus ; select which browser. TODO replace with hammerspoon
  chromium
  coconutbattery ; battery info util
  ;; corretto
  ;; corretto8
  ;; edex-ui
  firefox
  flux
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
  ;; lapce
  logseq ; personal knowledge management
  ;; meetingbar
  ;; noisebuddy
  ;; noisy
  ;; qutebrowser
  ;; rectangle ; TODO migrate to hammerspoon
  ;; retinizer
  ;; spotify
  ;; swiftdefaultappsprefpane
  telegram
  ;; telegram-desktop
  ;; todoist
  tomatobar ; pomodoro menubar
  vimr ; another vim GUI
  visual-studio-code
  ;; xbar
HEREDOC

cask_list=["", "alacritty", "browserosaurus", "chromium", "coconutbattery", "firefox", "flux", "font-droid-sans-mono-nerd-font", "font-iosevka-nerd-font", "font-jetbrains-mono-nerd-font", "font-juliamono", "font-roboto-mono-nerd-font", "google-cloud-sdk", "hammerspoon", "hiddenbar", "iina", "intellij-idea-ce", "itsycal", "logseq", "telegram", "tomatobar", "vimr", "visual-studio-code"]
installed = `brew list --cask`
cask_list.reject { |cask| installed.include? cask }

formula_list=""
cask_list=""
tap_list=""
tap_list.each { |tap| `brew tap "#{tap}"` }
formula_list.each { |formula| `brew install "#{formula}"` }
cask_list.each { |cask| `brew install --cask "#{cask}"` }
