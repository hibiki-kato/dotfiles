#!/usr/bin/env bash
set -euo pipefail

echo "Installing essential packages..."

if command -v apt >/dev/null 2>&1; then
  sudo apt install -y \
    git \
    curl \
    wget \
    build-essential \
    zsh \
    vim
  echo "✓ Essential packages installed"
else
  echo "⚠ apt not found, skipping"
fi
