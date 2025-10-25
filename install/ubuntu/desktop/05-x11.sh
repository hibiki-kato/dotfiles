#!/usr/bin/env bash
set -euo pipefail

# Minimal X11 stack for Ubuntu Desktop (no display manager/DE)
# Installs Xorg server and basic X11 utilities

# Skip on WSL (no real X server expected by default)
if grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null; then
  exit 0
fi

sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  xorg \
  xinit \
  x11-apps \
  x11-xserver-utils \
  xauth \
  mesa-utils
