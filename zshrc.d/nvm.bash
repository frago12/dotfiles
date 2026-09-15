export NVM_DIR="$HOME/.nvm"
export NODE_VERSIONS="${NVM_DIR}/versions/node"
export NODE_VERSION_PREFIX="v"

# Put the default Node on PATH without sourcing nvm.sh
_nvm_default_bin() {
  emulate -L zsh
  setopt noglob
  local alias_dir="$NVM_DIR/alias" target n=0
  [[ -r "$alias_dir/default" ]] || return 1
  target=$(<"$alias_dir/default")
  target=${target//$'\n'/}
  while [[ -r "$alias_dir/$target" && n -lt 8 ]]; do
    target=$(<"$alias_dir/$target")
    target=${target//$'\n'/}
    (( n++ ))
  done
  local bin="$NVM_DIR/versions/node/$target/bin"
  [[ -d "$bin" ]] || return 1
  print -r -- "$bin"
}

_nvm_bin="$(_nvm_default_bin)"
if [[ -n "$_nvm_bin" ]]; then
  export PATH="$_nvm_bin:$PATH"
fi
unset -f _nvm_default_bin
unset -v _nvm_bin

_nvm_load() {
  unset -f nvm _nvm_load
  [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh" --no-use
  local nvm_completion="${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm"
  [[ -s "$nvm_completion" ]] && . "$nvm_completion"
}

nvm() {
  _nvm_load
  nvm "$@"
}

_nvm_find_nvmrc() {
  local dir="$PWD"
  while true; do
    if [[ -f "$dir/.nvmrc" ]]; then
      print -r -- "$dir/.nvmrc"
      return 0
    fi
    [[ "$dir" == "/" ]] && return 1
    dir="${dir:h}"
  done
}

_nvm_using_nvmrc=0
load-nvmrc() {
  if _nvm_find_nvmrc >/dev/null; then
    nvm use --silent
    _nvm_using_nvmrc=1
  elif (( _nvm_using_nvmrc )); then
    nvm use default --silent
    _nvm_using_nvmrc=0
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd load-nvmrc
load-nvmrc
