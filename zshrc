# Custom config
setopt noincappendhistory
setopt nosharehistory

# Custom zshrc sources are stored in ~/.zshrc.d
if [[ -d $HOME/.zshrc.d ]] ; then
  for config in "$HOME"/.zshrc.d/*.bash ; do
    source "$config"
  done
fi
unset -v config

# Custom zshrc sources are stored in ~/.secrets.d
if [[ -d $HOME/.secrets.d ]] ; then
  for config in "$HOME"/.secrets.d/*.bash ; do
    source "$config"
  done
fi
unset -v config

# Add tab completion for bash completion 2
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

if command -v pyenv 1>/dev/null 2>&1; then  eval "$(pyenv init -)";fi;

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
