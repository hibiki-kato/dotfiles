#!/usr/bin/env zsh
set -euo pipefail

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

if flatpak list --app --columns=application | grep -qx "com.rustdesk.RustDesk"; then
  echo "RustDesk already installed, skipping."
else
  flatpak install -y flathub com.rustdesk.RustDesk
fi
