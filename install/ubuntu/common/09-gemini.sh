#!/usr/bin/env zsh
set -euo pipefail

if command -v gemini >/dev/null 2>&1; then
  echo "Gemini CLI already installed, skipping."
  gemini --version || true
  exit 0
fi

npm install -g @google/gemini-cli
