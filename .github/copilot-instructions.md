# GitHub Copilot Instructions

This file provides guidance to GitHub Copilot when working with code in this repository.

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
- `home/dot_config/` - Configuration files for various applications and is the target state of `~/.config`
- `.chezmoiroot` - Specifies that dotfiles are installed relative to `home/`

### Naming Conventions
- Files starting with `dot_` become `.` files in the home directory (e.g., `dot_zshrc` → `~/.zshrc`)
- Files ending with `.tmpl` are processed as Go templates with variable substitution
- Scripts in `.chezmoiscripts/` follow naming patterns that determine execution order and behavior:
  - `run_once_*` - Run once per machine
  - `run_onchange_*` - Run when the script content changes
  - `run_onchange_before_*` - Run before applying dotfiles
  - `run_onchange_after_*` - Run after applying dotfiles

### Template System
The repository uses chezmoi's template system with Go templates:
- `.tmpl` files are processed as templates with Go template syntax
- Variables are defined in `home/.chezmoi.toml.tmpl`
- 1Password integration via `onepasswordRead` function for secrets
- User prompts for email, hostname, and other personalization
- Template example: `{{ .email }}` accesses the email variable

### Script Execution Order
Chezmoi scripts run in a specific order based on their naming:
1. `run_onchange_before_*` - Run before applying dotfiles (e.g., package installation)
2. Apply dotfiles to the system
3. `run_onchange_after_*` - Run after applying dotfiles (e.g., system configuration)

### Key Components

#### Package Management (`run_onchange_before_install-packages.sh.tmpl`)
- Manages Homebrew taps, formulas, and casks
- Installs development tools, CLI utilities, and GUI applications
- Uses template variables to generate Brewfile content dynamically
- Lists of packages are defined using Go template arrays

#### System Configuration (`run_onchange_after_configure-defaults.sh`)
- Configures macOS system preferences via `defaults` commands
- Sets up Finder, keyboard, Safari, and trackpad preferences
- Creates screenshots directory and configures system behaviors
- Should be idempotent (safe to run multiple times)

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
- **1Password CLI and SSH agent integration** throughout the repository
- Git signing keys retrieved from 1Password using `onepasswordRead`
- SSH configuration templates for secure connections
- Password manager installation via pre-hook script (`.install-password-manager.sh`)
- **Never commit secrets or credentials** - always use 1Password references

### Development Tools Included
- **Editors**: neovim, helix, zed
- **Languages**: go, deno, python tooling via uv
- **CLI Tools**: bat, eza, fzf, ripgrep, fd, jq, gh, lazygit
- **Infrastructure**: terraform tooling, cloud CLIs (aws, doctl, flyctl)
- **Productivity**: gum, slides, starship prompt

## Coding Guidelines

### When Adding New Dotfiles
1. Use `chezmoi add <file>` to add files to the managed state
2. If the file contains secrets, use 1Password references via `onepasswordRead`
3. If the file needs personalization, convert it to a `.tmpl` file and use template variables
4. Test changes with `chezmoi apply --dry-run` before applying

### When Modifying Scripts
1. Scripts should be idempotent (safe to run multiple times)
2. Use `set -eufo pipefail` for error handling in Bash scripts
3. Consider the execution order based on script naming
4. For `run_onchange_*` scripts, they run when the content changes (including comments)

### When Adding Packages
1. Add to the appropriate list in `run_onchange_before_install-packages.sh.tmpl`:
   - `$taps` for Homebrew taps
   - `$brews` for command-line tools
   - `$casks` for GUI applications
2. Keep lists sorted alphabetically
3. The script uses `brew bundle` to install packages

### Testing and Validation
1. Always test chezmoi changes with `--dry-run` first: `chezmoi apply --dry-run`
2. For scripts, test manually before adding to chezmoi
3. Shell scripts should be validated with `shellcheck`
4. Verify that changes don't break existing dotfile applications

### Style Preferences
- Use Bash for scripts (not sh or zsh-specific syntax in scripts)
- Follow existing patterns and conventions in the repository
- Keep configuration organized by application in `home/dot_config/`
- Use descriptive names for scripts that indicate their purpose

## Common Tasks

### Adding a New Configuration File
```bash
# If the file doesn't contain secrets:
chezmoi add ~/.config/newapp/config.yml

# If it needs templating:
chezmoi add --template ~/.config/newapp/config.yml
# Then edit to add template variables
chezmoi edit ~/.config/newapp/config.yml
```

### Adding a New Package
Edit `home/.chezmoiscripts/run_onchange_before_install-packages.sh.tmpl` and add to the appropriate list.

### Updating System Defaults
Edit `home/.chezmoiscripts/run_onchange_after_configure-defaults.sh` and add new `defaults write` commands.

### Adding a New Setup Script
Create a new script in `home/.chezmoiscripts/` with the appropriate prefix:
- `run_once_*` for one-time setup
- `run_onchange_*` for scripts that should re-run when changed

## Important Notes

- This is a **macOS-focused** dotfiles repository
- The repository uses **chezmoi** for managing dotfiles, not a bare git repo or symlink approach
- **Security**: Never commit secrets directly - always use 1Password integration
- **Templates**: Go template syntax is used, not other templating languages
- **Testing**: Always use `chezmoi apply --dry-run` before applying changes
