#!/usr/bin/env bash

set -euo pipefail

echo "Configuring Dock"

add_app() {
	local app_name="$1"
	shift

	local app_path=""
	for candidate in "$@"; do
		if [[ -d "$candidate" ]]; then
			app_path="$candidate"
			break
		fi
	done

	if [[ -n "$app_path" ]]; then
		dockutil --no-restart --add "$app_path"
	else
		echo "Skipping $app_name: not found" >&2
	fi
}

dockutil --no-restart --remove all
add_app "Safari" \
	"/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app" \
	"/System/Cryptexes/App/System/Applications/Safari.app" \
	"/Applications/Safari.app"
add_app "Messages" \
	"/System/Applications/Messages.app" \
	"/Applications/Messages.app"
dockutil --no-restart --add "/Applications/Ghostty.app"
dockutil --no-restart --add "/Applications/Obsidian.app"
dockutil --no-restart --add "/Applications/Zed.app"
dockutil --no-restart --add "/Applications/1Password.app"
dockutil --no-restart --add "$HOME/Downloads" --view grid --display folder

# Dock: hide recent applications
defaults write com.apple.dock show-recents -bool false

killall Dock
