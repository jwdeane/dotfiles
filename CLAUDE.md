# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with [chezmoi](https://www.chezmoi.io/), a tool for managing dotfiles across multiple machines. The repository contains configuration files, shell scripts, and automation for setting up a macOS development environment.

## Key Commands

### Chezmoi Operations
- `chezmoi apply` - Apply dotfiles to the system
- `chezmoi apply --dry-run` - Preview changes without applying
- `chezmoi edit <file>` - Edit a dotfile in the source directory
- `chezmoi edit --apply <file>` - Edit and immediately apply changes
- `chezmoi add <file>` - Add a new file to be managed by chezmoi

### Useful Aliases (from dot_config/zsh/aliases)
- `cz` - chezmoi shorthand
- `cza` - chezmoi apply
- `czad` - chezmoi apply --dry-run
- `cze` - chezmoi edit
- `czea` - chezmoi edit --apply

### Installation
- Initial setup: `curl -fsSL https://raw.githubusercontent.com/jwdeane/dotfiles/HEAD/install.sh | sh`

## Architecture and Structure

### Directory Layout
- `home/` - Contains dotfiles that will be installed to the home directory
- `home/.chezmoiscripts/` - Contains scripts that run during chezmoi operations
- `home/dot_config/` - Configuration files for various applications
- `.chezmoiroot` - Specifies that dotfiles are installed relative to `home/`

### Template System
The repository uses chezmoi's template system with Go templates:
- `.tmpl` files are processed as templates
- Variables are defined in `home/.chezmoi.toml.tmpl`
- 1Password integration via `onepasswordRead` function for secrets
- User prompts for email, hostname, and other personalization

### Script Execution Order
Chezmoi scripts run in a specific order based on their naming:
1. `run_onchange_before_*` - Run before applying dotfiles (e.g., package installation)
2. `run_onchange_after_*` - Run after applying dotfiles (e.g., system configuration)

### Key Components

#### Package Management (`run_onchange_before_install-packages.sh.tmpl`)
- Manages Homebrew taps, formulas, and casks
- Installs development tools, CLI utilities, and GUI applications
- Uses template variables to generate Brewfile content

#### System Configuration (`run_onchange_after_configure-defaults.sh`)
- Configures macOS system preferences via `defaults` commands
- Sets up Finder, keyboard, Safari, and trackpad preferences
- Creates screenshots directory and configures system behaviors

#### Shell Configuration (`dot_zshrc.tmpl`)
- Configures Zsh with custom PATH, functions, and aliases
- Integrates with tools like fzf, starship, mise, and zoxide
- Uses antidote for plugin management
- 1Password SSH agent integration

#### Git Configuration (`dot_config/git/config.tmpl`)
- Personal Git configuration with aliases and preferences
- 1Password integration for SSH signing
- Custom diff and merge settings using diff-so-fancy

### Security Integration
- 1Password CLI and SSH agent integration throughout
- Git signing keys retrieved from 1Password
- SSH configuration templates for secure connections
- Password manager installation via pre-hook script

### Development Tools Included
- **Editors**: neovim, helix, zed
- **Languages**: go, deno, python tooling via uv
- **CLI Tools**: bat, eza, fzf, ripgrep, fd, jq, gh, lazygit
- **Infrastructure**: terraform tooling, cloud CLIs (aws, doctl, flyctl)
- **Productivity**: gum, slides, starship prompt

## Working with This Repository

When modifying this repository:
1. Files starting with `dot_` become `.` files in the home directory
2. Template files (`.tmpl`) are processed and variables substituted
3. Test changes with `chezmoi apply --dry-run` before applying
4. Scripts in `.chezmoiscripts/` will run when their content changes
5. Use 1Password references for any sensitive data via `onepasswordRead`
