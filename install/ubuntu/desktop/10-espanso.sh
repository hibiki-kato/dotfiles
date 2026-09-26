#!/usr/bin/env zsh
set -euo pipefail

if ! command -v espanso >/dev/null 2>&1; then
  if [[ "$(uname -m)" != "x86_64" ]]; then
    echo "Espanso Wayland .deb installer is amd64-only; skipping on $(uname -m)."
    exit 0
  fi

  deb_file="/tmp/espanso-debian-wayland-amd64.deb"
  wget -q https://github.com/espanso/espanso/releases/latest/download/espanso-debian-wayland-amd64.deb -O "$deb_file"
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "$deb_file"
  rm -f "$deb_file"
  sudo setcap "cap_dac_override+p" "$(command -v espanso)"
  espanso service register
else
  echo "espanso already installed, skipping."
fi
