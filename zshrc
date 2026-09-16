# Custom config
# setopt noincappendhistory
# setopt nosharehistory

# Custom zshrc sources are stored in ~/.zshrc.d
if [[ -d $HOME/.zshrc.d ]] ; then
  for config in "$HOME"/.zshrc.d/*.bash ; do
    source "$config"
  done
fi
unset -v config

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Autojump
[ -f "${HOMEBREW_PREFIX}/etc/profile.d/autojump.sh" ] && . "${HOMEBREW_PREFIX}/etc/profile.d/autojump.sh"

# Starship
export STARSHIP_CONFIG=~/dev/frago/dotfiles/config/starship.toml
eval "$(starship init $SHELL)"

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Load direnv
eval "$(direnv hook $SHELL)"

export HISTCONTROL=ignoredups

export EDITOR='nvim'

# pnpm
export PNPM_HOME="/Users/franciscogonzalez/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Go
if command -v go >/dev/null 2>&1; then
  export PATH="$PATH:$(go env GOPATH)/bin"
fi

# Load zsh-syntax-highlighting; should be last.
source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
