# rustup (keg-only) and the toolchain proxies it installs
[[ -d /opt/homebrew/opt/rustup/bin ]] && export PATH="/opt/homebrew/opt/rustup/bin:${PATH}"
[[ -d "${HOME}/.cargo/bin" ]] && export PATH="${HOME}/.cargo/bin:${PATH}"
