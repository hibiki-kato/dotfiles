#!/usr/bin/env bash
set -euo pipefail

echo "Setting up Homebrew..."

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # brew shellenv を zprofile に追記
  arch="$(uname -m)"
  if [[ "${arch}" == "arm64" ]]; then
    prefix="/opt/homebrew"
  else
    prefix="/usr/local"
  fi
  
  eval "$(${prefix}/bin/brew shellenv)"
  
  if ! grep -qs "brew shellenv" "$HOME/.zprofile" 2>/dev/null; then
    echo "eval \"\$(${prefix}/bin/brew shellenv)\"" >> "$HOME/.zprofile"
  fi
  
  echo "✓ Homebrew installed"
else
  echo "✓ Homebrew already installed"
fi
