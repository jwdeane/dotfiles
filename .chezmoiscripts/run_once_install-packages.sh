#!/usr/bin/env bash

set -eufo pipefail

check_and_install_brew() {
  echo -e "\nChecking brew..."

  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "→ brew already installed"
  fi
}

check_and_install_astral_packages() {
  echo -e "\nChecking astral packages..."

  packages=(
    "ruff" # ruff: https://github.com/astral-sh/ruff
    "uv"   # uv: https://github.com/astral-sh/uv
  )

  for pkg in "${packages[@]}"; do
    if ! command -v "${pkg}" >/dev/null 2>&1; then
      echo "Installing ${pkg}..."
      curl -LsSf https://astral.sh/${pkg}/install.sh | sh
    else
      echo "→ ${pkg} already available"
    fi
  done
}

# brew
check_and_install_brew
# astral packages
check_and_install_astral_packages
