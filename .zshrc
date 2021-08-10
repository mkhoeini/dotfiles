# Change to true to do a profiling on shell load
RUN_ZPROF=false

# This should remain at the top of file to do a proper profiling
if $RUN_ZPROF; then
  zmodload zsh/zprof
fi

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle :compinstall filename '/Users/mohammadk/.zshrc'

fpath+=~/.zfunc

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd beep extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

# Good options
setopt AUTO_LIST AUTO_MENU GLOB GLOB_DOTS GLOB_STAR_SHORT EXTENDED_HISTORY HIST_BEEP HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS SHARE_HISTORY

# Do menu-driven completion.
zstyle ':completion:*' menu select

# Color completion for some things.
# http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# formatting and messages
# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''


# ENV Configs

export PATH="$HOME/.bin:/usr/local/bin:$PATH"
export PATH="/Users/mohammadk/Library/Python/3.7/bin:$HOME/.config/yarn/global/node_modules/.bin:/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/:$PATH"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

export EDITOR='nvim'


# Aliases

alias b='brew'
alias bi='b install'
alias bs='b search'
alias bc='b cask'
alias bci='bc install'
alias bcs='bc search'
# alias l="exa -lahTL 2 --group-directories-first --git"
alias l="lsd -la"
alias kg="kubectl get"
alias kd="kubectl describe"

alias ec="emacsclient -cqua ''"

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g L='| less -R'
alias -g G='| grep -i'


# Antigen

source "$(brew --prefix)/share/antigen/antigen.zsh"


# This should remain as the last command in file to properly profile everything
if $RUN_ZPROF; then
  zprof
fi
