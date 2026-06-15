#!/usr/bin/env zsh
set -euo pipefail

mkdir -p "$HOME/.local"
export PATH="$HOME/.local/bin:$PATH"
export NPM_CONFIG_PREFIX="$HOME/.local"

if command -v bw >/dev/null 2>&1; then
  echo "Bitwarden CLI already installed, skipping."
  exit 0
fi

npm install -g --prefix "$HOME/.local" @bitwarden/cli
