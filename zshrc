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

if command -v pyenv 1>/dev/null 2>&1; then  eval "$(pyenv init -)";fi;

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export LDFLAGS=
eval "$(rbenv init - $SHELL)"

# Autojump
[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Starship
export STARSHIP_CONFIG=~/dev/frago/dotfiles/config/starship.toml
eval "$(starship init $SHELL)"

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Load direnv
eval "$(direnv hook $SHELL)"
export NODE_VERSIONS="${NVM_DIR}/versions/node"
export NODE_VERSION_PREFIX="v"

export HISTCONTROL=ignoredups

# Load zsh-syntax-highlighting; should be last.
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export EDITOR='nvim'

# pnpm
export PNPM_HOME="/Users/franciscogonzalez/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Go
export PATH="$PATH:$(go env GOPATH)/bin"

# if [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then...fi
