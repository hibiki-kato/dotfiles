#!/usr/bin/env zsh
set -euo pipefail

echo "Installing Homebrew packages..."

brew bundle  --global

echo "✓ Homebrew packages installed"
