#!/usr/bin/env zsh
set -euo pipefail

if ! command -v espanso >/dev/null 2>&1; then
  if [[ "$(uname -m)" != "x86_64" ]]; then
    echo "Espanso X11 .deb installer is amd64-only; skipping on $(uname -m)."
    exit 0
  fi

  deb_file="/tmp/espanso-debian-x11-amd64.deb"
  wget -q https://github.com/espanso/espanso/releases/latest/download/espanso-debian-x11-amd64.deb -O "$deb_file"
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "$deb_file"
  rm -f "$deb_file"
  espanso register
else
  echo "espanso already installed, skipping."
fi
