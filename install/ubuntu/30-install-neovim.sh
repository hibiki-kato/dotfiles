#!/usr/bin/env bash
set -euo pipefail

echo "Installing Neovim..."

NVIM_VERSION="v0.10.0"

if command -v nvim >/dev/null 2>&1; then
  echo "✓ Neovim already installed"
  exit 0
fi

cd /tmp
curl -LO "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux64.tar.gz"
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
rm nvim-linux64.tar.gz

echo "✓ Neovim installed"
