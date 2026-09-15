export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init - --no-rehash zsh)"
fi
