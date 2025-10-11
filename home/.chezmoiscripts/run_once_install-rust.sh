#!/usr/bin/env bash
set -euo pipefail

# Check if rustup is already installed
if ! command -v rustup >/dev/null 2>&1; then
  echo "Installing rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
else
  echo "rustup already installed, updating..."
  rustup self update || true
fi

# Update and configure Rust
source "$HOME/.cargo/env"
rustup update stable
rustup default stable
rustup component add rustfmt clippy

echo "Rust setup complete!"
