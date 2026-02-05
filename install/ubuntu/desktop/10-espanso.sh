#!/bin/zsh
set -euo pipefail

if ! command -v espanso >/dev/null 2>&1; then
  wget -q https://github.com/espanso/espanso/releases/latest/download/espanso-debian-x11-amd64.deb
  sudo apt install -y ./espanso-debian-x11-amd64.deb
  espanso register
else
  echo "espanso already installed, skipping."
fi
