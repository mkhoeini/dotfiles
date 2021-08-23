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

export EDITOR='nvim'


# Antigen

source "$(brew --prefix)/share/antigen/antigen.zsh"
antigen init ~/.antigenrc


# Aliases

source ~/.zsh_aliases


# Configs

if [[ -e  "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ]]; then
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi
[[ -n $commands[starship] ]] && . <(starship init zsh)
# Use java_home instead as it is much faster
# if command -v jenv &>/dev/null; then
  # export PATH="$HOME/.jenv/bin:$PATH"
  # . <(jenv init -)
# fi
if [[ -x /usr/libexec/java_home ]]; then
  export JAVA_HOME="$(/usr/libexec/java_home -v 11)"
fi

function username_to_userid {
 jhurl -p --site services.gew1 --method GET "hm://userdata/account?username=$1" 2>/dev/null | jq ".[] | .user_id"
}

function userid_to_username {
  jhurl -p --site services.gew1 --method GET "hm://userdata/account?user_id=$1" 2>/dev/null | jq ".[] | .username"
}

bindkey '^G' per-directory-history-toggle-history
bindkey '^T' fzf-file-widget
bindkey '^R' fzf-history-widget
# bindkey '^I' fzf-completion

PONYSAY="$(shuf -n 1 -e ponysay ponythink) -f $(shuf -n 1 -e $(ponysay --all | grep -v 'ponies located in'))"
COWSAY="$(shuf -n 1 -e cowsay cowthink) -$(shuf -n 1 -e b d g p s t w y) -f $(shuf -n 1 -e $(cowsay -l | tail -n +2)) -n | lolcat"
fortune | eval $(shuf -n 1 -e "$PONYSAY" "$COWSAY" $(seq -f cat 20))

# This should remain as the last command in file to properly profile everything
if $RUN_ZPROF; then
  zprof
fi
