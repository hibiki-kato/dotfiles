#!/usr/bin/env bash
set -euo pipefail

wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg -i chrome-remote-desktop_current_amd64.deb || true
sudo apt-get -f install -y
rm chrome-remote-desktop_current_amd64.deb

sudo groupadd chrome-remote-desktop || true
sudo usermod -a -G chrome-remote-desktop "$USER"
