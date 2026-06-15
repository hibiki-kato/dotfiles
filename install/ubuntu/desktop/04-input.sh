#!/usr/bin/env zsh
set -euo pipefail

sudo apt-get update -y || true
sudo apt-get install -y gnome-tweak-tool \
  fcitx5-mozc \
  gnome-tweaks
