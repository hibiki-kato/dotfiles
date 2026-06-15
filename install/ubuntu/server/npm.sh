#!/usr/bin/env zsh
set -euo pipefail

if command -v bw >/dev/null 2>&1; then
  echo "Bitwarden CLI already installed, skipping."
  exit 0
fi

mkdir -p "$HOME/.local"
npm config set prefix "$HOME/.local"
export PATH="$HOME/.local/bin:$PATH"

npm install -g @bitwarden/cli
