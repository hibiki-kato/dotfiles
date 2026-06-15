#!/usr/bin/env zsh
set -euo pipefail

if command -v warp-terminal >/dev/null 2>&1; then
  echo "Warp already installed, skipping."
  exit 0
fi

if [[ "$(uname -m)" != "x86_64" ]]; then
  echo "Warp apt repository is configured for amd64; skipping on $(uname -m)."
  exit 0
fi

wget -qO- https://releases.warp.dev/linux/keys/warp.asc | gpg --dearmor > warpdotdev.gpg
sudo install -D -o root -g root -m 644 warpdotdev.gpg /etc/apt/keyrings/warpdotdev.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/warpdotdev.gpg] https://releases.warp.dev/linux/deb stable main" > /etc/apt/sources.list.d/warpdotdev.list'
rm warpdotdev.gpg
sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y warp-terminal
