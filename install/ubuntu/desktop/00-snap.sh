#!/usr/bin/env zsh
set -euo pipefail

# Install snap packages for Ubuntu Desktop
sudo snap install \
  zotero-snap \
  chatgpt-desktop \
  bitwarden \
  bw \
  surfshark \
  steam \
  discord \
  spotify \
  mission-center \
  uv \

sudo snap install --classic \
  code
