# AGENTS.md

This file provides guidance to coding agents when working with code in this repository.

## Repository Structure

This is a personal dotfiles repository for macOS development environment setup. The main components are:

- **Shell Configuration**: `zshrc` with modular configuration files in `zshrc.d/`
- **Package Management**: `Brewfile` for Homebrew packages
- **Terminal Theming**: `config/starship.toml` for shell prompt, terminal color schemes
- **Agent Instructions**: `agents/AGENTS.md` holds the global instructions for every agent, symlinked as `~/.claude/CLAUDE.md` (via `claude/CLAUDE.md`) and `~/.codex/AGENTS.md` (by `install.sh`)
- **Agent Skills**: `agents/skills/` holds every skill (own and third-party), symlinked to `~/.agents` and linked into Claude Code by `install.sh`
- **Agent Plugins**: `claude/settings.json` (`enabledPlugins`) for Claude Code, `codex/plugins.txt` for Codex
- **Installation Script**: `install.sh` for symlinking dotfiles

## Common Commands

### Setup and Installation
```bash
# Initial setup (copy and customize install script)
cp install.sh.example install.sh
# Edit install.sh to set correct paths
./install.sh

# Update brew (incl. leftover cleanup), Node LTS, rust, and grok
dotup

# Reload shell configuration
reload
```

### Development Environment
```bash
# Common aliases available:
ll                 # List files with details
..                 # Go up one directory
flushdns          # Flush DNS cache
```

## Architecture

### Modular Shell Configuration
The `zshrc` file sources all `.bash` files from `zshrc.d/` directory, providing modular configuration for:
- Language-specific setups (Node.js, Python, Ruby)
- Tool configurations (Git, PostgreSQL, SSH)
- Aliases and autocompletions

### Environment Management
- **Python**: pyenv for version management
- **Node.js**: nvm with the current Node LTS as default
- **Ruby**: rbenv for version management
- **Terminal**: Starship prompt with custom configuration

### Package Management Strategy
- **Homebrew**: Primary package manager with comprehensive Brewfile

## Key Configuration Files

- `zshrc.d/aliases.bash`: Custom command aliases and shortcuts
- `config/starship.toml`: Terminal prompt customization
- `Brewfile`: Complete development environment package list