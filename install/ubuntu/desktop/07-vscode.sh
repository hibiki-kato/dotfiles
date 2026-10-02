#!/usr/bin/env zsh
set -euo pipefail

if command -v code >/dev/null 2>&1; then
  echo "VS Code already installed, skipping."
  exit 0
fi

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
rm microsoft.gpg
sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null <<'SOURCES'
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-By: /usr/share/keyrings/microsoft.gpg
SOURCES
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y code
