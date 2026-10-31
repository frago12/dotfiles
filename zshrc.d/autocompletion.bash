# Zsh completion
if [[ -d "${HOMEBREW_PREFIX}/share/zsh/site-functions" ]]; then
  FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
fi
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
# -C reuses ~/.zcompdump without rescanning; dotup deletes it after installing formulae.
compinit -C
_comp_options+=(globdots) # Include hidden files.
