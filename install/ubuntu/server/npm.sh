#!/usr/bin/env zsh
set -euo pipefail

if command -v bw >/dev/null 2>&1; then
  echo "Bitwarden CLI already installed, skipping."
  exit 0
fi

npm install -g @bitwarden/cli
