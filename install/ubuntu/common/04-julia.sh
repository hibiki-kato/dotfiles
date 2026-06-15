#!/usr/bin/env zsh
set -euo pipefail

if command -v juliaup >/dev/null 2>&1; then
  echo "Juliaup already installed, skipping."
elif [[ -x "$HOME/.juliaup/bin/juliaup" ]] || [[ -d "$HOME/.juliaup" ]]; then
  echo "Juliaup directory already exists, skipping install: $HOME/.juliaup"
else
  curl -fsSL https://install.julialang.org | zsh -s -- -y
fi
