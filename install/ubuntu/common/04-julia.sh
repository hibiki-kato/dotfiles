#!/usr/bin/env zsh
set -euo pipefail

if command -v juliaup >/dev/null 2>&1; then
  echo "Juliaup already installed, skipping."
else
  curl -fsSL https://install.julialang.org | zsh -s -- -y
fi
