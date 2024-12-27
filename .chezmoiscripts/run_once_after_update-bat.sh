#!/usr/bin/env bash

set -eufo pipefail

# remove syntax files which break bat
# ref: https://hynek.me/til/bat-justfile/
rm -f \
  "$(bat --config-dir)/syntaxes/just_sublime/Syntax/Embeddings/Python (for Just).sublime-syntax" \
  "$(bat --config-dir)/syntaxes/just_sublime/Syntax/Embeddings/ShellScript (for Just).sublime-syntax"

# rebuild bat's cache after installing theme(s)
bat cache --build
