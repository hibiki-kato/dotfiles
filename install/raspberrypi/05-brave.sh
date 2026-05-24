#!/usr/bin/env zsh
set -euo pipefail

if command -v brave-browser >/dev/null 2>&1; then
  echo "Brave already installed, skipping."
  exit 0
fi

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
  https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources \
  https://brave-browser-apt-release.s3.brave.com/brave-browser.sources

sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y brave-browser
