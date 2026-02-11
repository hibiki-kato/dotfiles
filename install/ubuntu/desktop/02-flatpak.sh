#!/usr/bin/env zsh
set -euo pipefail

sudo apt-get -y install flatpak \
    gnome-software-plugin-flatpak

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.rustdesk.RustDesk
flatpak install -y flathub io.github.jeffshee.Hidamari
# flatpak install -y flathub org.openrgb.OpenRGB