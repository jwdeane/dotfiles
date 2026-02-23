#!/usr/bin/env bash

set -euo pipefail

mkdir -p "$HOME/.deno/bin"
mkdir -p "$HOME/.go/bin"
mkdir -p "$HOME/.config/volta/bin"
mkdir -p "$HOME/.config/zsh/completions" "$HOME/.config/zsh/functions"

if [[ "$(uname -s)" == "Darwin" ]]; then
	if ! command -v brew >/dev/null 2>&1; then
		echo "Homebrew is required but was not found in PATH" >&2
		exit 1
	fi

	source_dir="${CHEZMOI_SOURCE_DIR:-$HOME/.local/share/chezmoi}"
	brewfile="$source_dir/dot_Brewfile"

	if [[ -f "$HOME/.Brewfile" ]]; then
		brewfile="$HOME/.Brewfile"
	fi

	if [[ ! -f "$brewfile" ]]; then
		echo "Brewfile not found at $brewfile" >&2
		exit 1
	fi

	brew bundle --file="$brewfile"
fi

if ! command -v uv >/dev/null 2>&1; then
	echo "Installing uv..."
	curl -LsSf https://astral.sh/uv/install.sh | sh
else
	echo "uv is already installed"
fi

if ! command -v ruff >/dev/null 2>&1; then
	echo "Installing ruff..."
	uv tool install ruff@latest
else
	echo "ruff is already installed"
fi

if ! command -v bun >/dev/null 2>&1; then
	echo "Installing bun..."
	curl -fsSL https://bun.sh/install | bash
else
	echo "bun is already installed"
fi
