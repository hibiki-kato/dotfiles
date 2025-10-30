#!/usr/bin/env zsh
set -euo pipefail

echo "Installing Xcode Command Line Tools..."

if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install || true
  echo "Waiting for Command Line Tools installation to complete..."
  until xcode-select -p >/dev/null 2>&1; do 
    sleep 5
  done
  echo "✓ Xcode Command Line Tools installed"
else
  echo "✓ Xcode Command Line Tools already installed"
fi
