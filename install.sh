#!/bin/bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" || "$(uname -m)" != "arm64" ]]; then
	echo "This bootstrap script requires Apple Silicon macOS." >&2
	exit 1
fi

if ! command -v brew &>/dev/null; then
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

if ! command -v chezmoi &>/dev/null; then
	brew install chezmoi
fi

exec chezmoi init --apply jwdeane
