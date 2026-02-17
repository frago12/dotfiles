# Add ~/.bin to PATH for custom scripts
[[ -d ~/.bin ]] && export PATH="${HOME}/.bin:${PATH}"

# Add ~/.local/bin to PATH for local installations (e.g., Claude Code)
[[ -d ~/.local/bin ]] && export PATH="${HOME}/.local/bin:${PATH}"

# Ripgrep global config
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"
