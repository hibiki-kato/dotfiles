#!/usr/bin/env bash
set -euo pipefail

echo "Installing Homebrew packages..."

# brew を読み込む
if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Brewfile の場所を優先順に探す
INSTALL_DIR="${INSTALL_DIR:-$(dirname "$(dirname "$0")")}"

if [[ -f "$HOME/.Brewfile" ]]; then
  echo "Using ~/.Brewfile"
  brew bundle --global
elif [[ -f "$INSTALL_DIR/macos/Brewfile" ]]; then
  echo "Using install/macos/Brewfile"
  brew bundle --file="$INSTALL_DIR/macos/Brewfile"
else
  echo "⚠ No Brewfile found, skipping"
  exit 0
fi

echo "✓ Homebrew packages installed"
