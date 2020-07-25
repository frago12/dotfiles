export ZSH_DISABLE_COMPFIX=true

# Custom zshrc sources are stored in ~/.zshrc.d
if [[ -d $HOME/.zshrc.d ]] ; then
  for config in "$HOME"/.zshrc.d/*.bash ; do
    source "$config"
  done
fi
unset -v config

# Add tab completion for bash completion 2
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

if command -v pyenv 1>/dev/null 2>&1; then  eval "$(pyenv init -)";fi;
