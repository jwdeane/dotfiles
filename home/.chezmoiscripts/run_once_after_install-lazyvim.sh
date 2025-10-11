#!/usr/bin/env bash
set -euo pipefail

NVIM_DIR="$HOME/.config/nvim"

if [ ! -d "$NVIM_DIR" ]; then
  echo "Installing LazyVim..."
  git clone https://github.com/LazyVim/starter "$NVIM_DIR"
  rm -rf "$NVIM_DIR/.git"
else
  echo "LazyVim already installed, skipping."
fi
