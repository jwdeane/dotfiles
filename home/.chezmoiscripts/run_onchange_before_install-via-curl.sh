#!/usr/bin/env bash

set -eufo pipefail

# Install uv if not already present
if ! command -v uv &>/dev/null; then
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
else
  echo "uv is already installed"
fi

# Install ruff if not already present
if ! command -v ruff &>/dev/null; then
  echo "Installing ruff..."
  uv tool install ruff@latest
else
  echo "ruff is already installed"
fi

# Install bun if not already present
if ! command -v bun &>/dev/null; then
  echo "Installing bun..."
  curl -fsSL https://bun.sh/install | bash
else
  echo "bun is already installed"
fi
