#!/usr/bin/env bash

set -euo pipefail

echo "Configuring Dock"
dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Safari.app"
dockutil --no-restart --add "/Applications/Messages.app"
dockutil --no-restart --add "/Applications/Ghostty.app"
dockutil --no-restart --add "/Applications/Obsidian.app"
dockutil --no-restart --add "/Applications/Zed.app"
dockutil --no-restart --add "/Applications/1Password.app"
dockutil --no-restart --add "/Applications/Claude.app"
dockutil --no-restart --add "~/Downloads" --view grid --display folder

# Dock: hide recent applications
defaults write com.apple.dock show-recents -bool false

killall Dock
