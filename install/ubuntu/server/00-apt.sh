#!/usr/bin/env zsh
set -euo pipefail

sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  pipewire \
  wireplumber \
  pipewire-pulse \
  libpulse-dev \
  alsa-utils \
  bluez \
  bluetooth \
  fzf \
  kmscon \
  locales \
  uim \
  uim-fep \
  uim-mozc \
  mozc-server \
  mpv \
  kbd \
  fonts-noto-cjk
