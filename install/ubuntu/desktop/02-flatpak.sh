#!/usr/bin/env zsh
set -euo pipefail

sudo apt-get -y install flatpak \
  gnome-software-plugin-flatpak

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

packages=(
  com.rustdesk.RustDesk
  io.github.jeffshee.Hidamari
)

for pkg in "${packages[@]}"; do
  flatpak install -y flathub "$pkg"
done
