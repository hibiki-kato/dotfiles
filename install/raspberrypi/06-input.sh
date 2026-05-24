#!/usr/bin/env zsh
set -euo pipefail

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  fcitx5 \
  fcitx5-mozc \
  im-config

im-config -n fcitx5 || true
