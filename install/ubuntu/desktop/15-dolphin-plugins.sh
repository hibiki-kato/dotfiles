#!/usr/bin/env zsh
set -euo pipefail

# dolphin-plugins provides the KDE Dropbox context-menu and sync-state plugin.
# Do not install Dolphin or its plugin stack on desktops that do not use it.
if ! command -v dolphin >/dev/null 2>&1; then
  echo "Dolphin not installed; skipping dolphin-plugins."
  exit 0
fi

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y dolphin-plugins
