#!/usr/bin/env zsh
set -euo pipefail

if command -v ollama >/dev/null 2>&1; then
  echo "Ollama already installed, skipping."
  exit 0
fi

curl -fsSL https://ollama.com/install.sh | sh
