#!/usr/bin/env zsh
set -euo pipefail

sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  cups \
  printer-driver-gutenprint \
  avahi-daemon

sudo systemctl enable --now cups avahi-daemon
sudo usermod -aG lpadmin "$USER"
