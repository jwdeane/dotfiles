#!/usr/bin/env bash

if ! gh auth status; then
  echo "gh is not authenticated. Authenticating..."
  gh auth login --web
fi

gh extension install github/gh-copilot --force
gh extension install yusukebe/gh-markdown-preview --force
