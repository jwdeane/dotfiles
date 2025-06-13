#!/bin/bash
set -euo pipefail

if ! command -v brew &>/dev/null; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if ! command -v chezmoi &>/dev/null; then
  brew install chezmoi
fi

exec chezmoi init --apply jwdeane
