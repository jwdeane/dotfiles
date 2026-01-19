# AGENTS.md

Guidelines for agentic coding assistants (Claude, Copilot) working in this repository.

## Repository Summary

This is a **personal macOS dotfiles repository** managed with [chezmoi](https://www.chezmoi.io/). It contains configuration files, shell scripts, and automation for setting up a complete macOS development environment. This is **not** a traditional software project—it's infrastructure-as-code for system configuration.

## Build, Test & Validation Commands

### Chezmoi Operations (Primary)
```bash
chezmoi apply --dry-run      # Always test changes first (no side effects)
chezmoi apply                # Apply dotfiles to the system
chezmoi edit <file>          # Edit a dotfile in the source directory
chezmoi edit --apply <file>  # Edit and immediately apply changes
chezmoi add <file>           # Add a new file to management
```

### Shell Script Validation
```bash
shellcheck <script>          # Validate Bash syntax
shfmt -d <script>            # Check shell formatting
```

### No Build/Test Framework
- This repository has **no unit tests, no build process, no CI/CD linting**
- Validation happens through `chezmoi apply --dry-run`
- Manual testing is required for scripts
- Changes should be tested before applying to the system

## Code Style Guidelines

### Bash/Shell Scripts

**Error Handling**: Use strict mode at the start of every script
```bash
#!/bin/bash
set -euo pipefail
```

**Script Naming**: Place in `home/.chezmoiscripts/` with proper prefixes
- `run_once_*` — Runs once per machine
- `run_onchange_*` — Runs when content changes
- `run_onchange_before_*` — Before dotfile application (e.g., package install)
- `run_onchange_after_*` — After dotfile application (e.g., system config)

**Idempotency**: All scripts must be safe to run multiple times
- Check if something exists before creating it
- Don't fail if a package is already installed
- Use `|| true` for non-critical operations

**Style Preferences**
- Use Bash (not sh or zsh-specific syntax in scripts)
- Quote variables: `"$var"` not `$var`
- Use arrays for lists, keep sorted alphabetically
- Follow existing patterns in the repository

### File Naming & Templates

**Dotfile Naming**: Files starting with `dot_` become `.` files
- `dot_zshrc` → `~/.zshrc`
- `dot_config/git/config.tmpl` → `~/.config/git/config`

**Template Files**: Files ending with `.tmpl` use Go template syntax
- Variables: `{{ .email }}`, `{{ .hostname }}`
- Conditionals: `{{ if .set_hostname }}...{{ end }}`
- Functions: `{{ onepasswordRead "op://..." }}`
- Define variables in `home/.chezmoi.toml.tmpl`

### Security & Secrets

**Critical Rule**: Never commit secrets or credentials directly

**Use 1Password Integration**
```bash
{{ onepasswordRead "op://vault/item/field" }}
```

**Examples**
- Git signing keys via `onepasswordRead`
- SSH keys via 1Password agent
- API tokens via secrets templates

### Homebrew Package Management

Edit `home/.chezmoiscripts/run_onchange_before_install-packages.sh.tmpl`

**Format**: Define arrays in Go template, use `brew bundle`
```bash
{{ if eq .chezmoi.os "darwin" }}
taps:
  - tap1
  - tap2
brews:
  - ansible
  - awscli
  - bat
casks:
  - arc
  - ghostty
  - zed
{{ end }}
```

**Rules**
- Keep each list sorted alphabetically
- Add to `$taps` for Homebrew taps
- Add to `$brews` for CLI tools
- Add to `$casks` for GUI applications
- Test with `chezmoi apply --dry-run`

### Imports & Dependencies

**Language Support**
- **Bash**: Primary scripting language
- **Go Templates**: Configuration templating
- **Python**: Via `uv` (Astral's package manager)
- **JavaScript/Node**: Via `bun` runtime
- **Go, Rust, Deno**: Available via package installation

**Tool Integration**
- `fzf` - Fuzzy finder
- `ripgrep` - Fast grep
- `starship` - Shell prompt
- `zoxide` - Smart cd
- `bat`, `eza` - Modern replacements
- `just` - Command runner

### Formatting & Standards

**Shell Formatting**: Use `shfmt` conventions
- 2-space indentation
- Consistent quote usage
- Clear function definitions

**Configuration Files**
- TOML: `home/dot_config/starship.toml`
- YAML: Various config files
- JSON: Editor configs (Zed, VS Code)
- Keep organized by application

**Naming Conventions**
- Variables: `UPPER_CASE` (environment), `lower_case` (local)
- Functions: `lowercase_with_underscores`
- Private vars: `_prefixed_with_underscore`
- Descriptive names that indicate purpose

### Error Handling

**In Bash Scripts**
```bash
set -euo pipefail           # Exit on error, undefined vars, pipe failures

if ! command -v tool &>/dev/null; then
  echo "Error: tool not found" >&2
  exit 1
fi

result=$(command) || {
  echo "Error: command failed" >&2
  exit 1
}
```

**For System Commands**
- Use absolute paths when possible: `/usr/bin/env bash`
- Check prerequisites before running
- Provide clear error messages to stderr

**Best Practices**
- Never suppress errors silently
- Log failures with context
- Use `|| true` only for truly non-critical operations
- Exit with appropriate status codes

## Working with Chezmoi

### Before Making Changes
1. Understand the file will be deployed to the system
2. Test destructive changes with `--dry-run` first
3. Check if the change affects multiple files/configs
4. Consider idempotency and repeated runs

### When Adding Dotfiles
- Use `chezmoi add <file>` to add to managed state
- If it contains secrets, use `{{ onepasswordRead }}`
- If it needs personalization, convert to `.tmpl`
- Test with `chezmoi apply --dry-run`

### When Modifying Scripts
- Ensure scripts are idempotent (safe to run repeatedly)
- Use `set -euo pipefail` for error handling
- Consider execution order (before vs. after)
- Remember `run_onchange_*` runs when content changes

### Common Patterns

**Check if something exists**
```bash
if [[ ! -d "$HOME/.config/app" ]]; then
  mkdir -p "$HOME/.config/app"
fi
```

**Install only if missing**
```bash
if ! brew list app &>/dev/null; then
  brew install app
fi
```

**Use relative paths in templates**
```bash
{{ .chezmoi.homeDir }}/.config/app
{{ .chezmoi.workingTree }}/some/file
```

## Key Architecture Points

**Directory Structure**
- `home/` — Managed dotfiles (files become ~/.config, ~/, etc.)
- `home/.chezmoiscripts/` — Automation scripts with execution order
- `home/dot_config/` — Target state of ~/.config
- `.chezmoiroot` — Indicates dotfiles are in home/

**Execution Phases**
1. `run_onchange_before_*` scripts execute
2. Dotfiles are applied to the system
3. `run_onchange_after_*` scripts execute

**Template Variables** (from `home/.chezmoi.toml.tmpl`)
- `.email` — User email
- `.hostname` — System hostname
- `.set_hostname` — Whether to set hostname
- `.chezmoi.os` — Operating system
- `.chezmoi.homeDir` — Home directory path
- `.chezmoi.workingTree` — Repository path

## Important Constraints

- **macOS-focused**: This repository targets macOS (but has conditional support for other systems)
- **No unit tests**: Testing is manual via `--dry-run`
- **Idempotency required**: All scripts must be safe to run multiple times
- **No secrets in repo**: Always use 1Password integration
- **No external formatting tools required**: Use existing standards (shfmt, shellcheck when available)

## References

- [chezmoi documentation](https://www.chezmoi.io/)
