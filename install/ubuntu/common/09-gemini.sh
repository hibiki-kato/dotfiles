#!/usr/bin/env zsh
set -euo pipefail

mkdir -p "$HOME/.local"
export PATH="$HOME/.local/bin:$PATH"
export NPM_CONFIG_PREFIX="$HOME/.local"

if command -v gemini >/dev/null 2>&1; then
  echo "Gemini CLI already installed, skipping."
  gemini --version || true
  exit 0
fi

npm install -g --prefix "$HOME/.local" @google/gemini-cli
