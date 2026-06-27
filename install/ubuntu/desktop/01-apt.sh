#!/usr/bin/env zsh
set -euo pipefail

sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  flatpak \
  stacer \
  indicator-multiload \
  copyq \
  vlc \
  ffmpeg \
  redshift \
  ripgrep \
  aria2 \
  flameshot
