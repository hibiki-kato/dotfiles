#!/usr/bin/env zsh
set -euo pipefail

sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  pipewire \
  wireplumber \
  pipewire-pulse \
  alsa-utils \
  bluez \
  bluetooth \
  uim \
  uim-fep \
  uim-mozc \
  mozc-server \
  fonts-noto-cjk
