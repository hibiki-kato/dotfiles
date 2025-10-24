#!/usr/bin/env bash
set -euo pipefail

echo "Installing essential packages..."

if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get install -y \
    git \
    curl \
    wget \
    build-essential \
    zsh \
    vim
  echo "✓ Essential packages installed"
else
  echo "⚠ apt-get not found, skipping"
fi
