# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

This is a personal dotfiles repository for macOS development environment setup. The main components are:

- **Shell Configuration**: `zshrc` with modular configuration files in `zshrc.d/`
- **Package Management**: `Brewfile` for Homebrew packages and `Gemfile` for Ruby gems
- **Terminal Theming**: `config/starship.toml` for shell prompt, terminal color schemes
- **Tmux Configuration**: `tmux.conf` with plugin management via TPM
- **Installation Script**: `install.sh` for symlinking dotfiles

## Common Commands

### Setup and Installation
```bash
# Initial setup (copy and customize install script)
cp install.sh.example install.sh
# Edit install.sh to set correct paths
./install.sh

# Install/update all Homebrew packages
brewup

# Install Ruby gems
bundle install

# Reload shell configuration
reload
```

### Development Environment
```bash
# Tmux session management
ta <session-name>  # Attach to tmux session

# Common aliases available:
ll                 # List files with details
..                 # Go up one directory
flushdns          # Flush DNS cache
lock              # Lock screen
```

## Architecture

### Modular Shell Configuration
The `zshrc` file sources all `.bash` files from `zshrc.d/` directory, providing modular configuration for:
- Language-specific setups (Node.js, Python, Ruby)
- Tool configurations (Git, PostgreSQL, SSH)
- Aliases and autocompletions

### Environment Management
- **Python**: pyenv for version management
- **Node.js**: nvm with Node 22 as default
- **Ruby**: rbenv for version management
- **Terminal**: Starship prompt with custom configuration

### Package Management Strategy
- **Homebrew**: Primary package manager with comprehensive Brewfile
- **Ruby Gems**: Minimal gem dependencies via Gemfile
- **Tmux Plugins**: TPM (Tmux Plugin Manager) with sensible defaults and Catppuccin theme

## Key Configuration Files

- `zshrc.d/aliases.bash`: Custom command aliases and shortcuts
- `config/starship.toml`: Terminal prompt customization
- `tmux.conf`: Tmux configuration with mouse support and custom key bindings
- `Brewfile`: Complete development environment package list