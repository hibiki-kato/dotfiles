#!/bin/zsh
set -euo pipefail

# if juliaup already exists, update it; otherwise install
if command -v juliaup >/dev/null 2>&1; then
    echo "Juliaup already installed — updating..."
else
    curl -fsSL https://install.julialang.org | zsh -s -- -y
fi

# source zshrc only if present
source ~/.zshrc || true