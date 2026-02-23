# dotfiles

Personal macOS dotfiles managed with [`chezmoi`](https://www.chezmoi.io/).

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/jwdeane/dotfiles/HEAD/install.sh | sh
```

## Day-to-day

```bash
chezmoi apply --dry-run
chezmoi apply
chezmoi edit dot_zshrc
```

## Layout

- Repository root is the chezmoi source root (no `home/` subdirectory).
- Dotfiles use chezmoi naming (`dot_zshrc` -> `~/.zshrc`, `dot_config/*` -> `~/.config/*`).
- Homebrew packages are managed in `dot_Brewfile` (`~/.Brewfile`).
- Automation scripts live in `.chezmoiscripts/`.
