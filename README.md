# dotfiles

Personal macOS dotfiles managed with [`chezmoi`](https://www.chezmoi.io/).

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/jwdeane/dotfiles/HEAD/install.sh | sh
```

What `install.sh` does:

- Verifies Apple Silicon macOS.
- Installs Homebrew if missing.
- Installs `chezmoi` if missing.
- Runs `chezmoi init --apply jwdeane`.

During `chezmoi init --apply`, a pre-hook installs 1Password and the 1Password CLI (`op`) if needed:

- Hook definition: [`.chezmoi.toml.tmpl`](.chezmoi.toml.tmpl)
- Hook script: [`.install-password-manager.sh`](.install-password-manager.sh)

## Day-to-day

```bash
chezmoi apply --dry-run
chezmoi apply
chezmoi edit dot_zshrc
```

Useful commands:

```bash
chezmoi diff
chezmoi status
chezmoi doctor
```

When changing shell scripts, validate with:

```bash
shellcheck path/to/script.sh
shfmt -d path/to/script.sh
```

## Layout

- Repository root is the chezmoi source root (no `home/` subdirectory).
- Dotfiles use chezmoi naming (`dot_zshrc` -> `~/.zshrc`, `dot_config/*` -> `~/.config/*`).
- Homebrew packages are managed in `dot_Brewfile` (`~/.Brewfile`).
- Automation scripts live in `.chezmoiscripts/`.

## Notes

- Never commit secrets directly; use templates and secret integrations.
- Test changes with `chezmoi apply --dry-run` before applying.
