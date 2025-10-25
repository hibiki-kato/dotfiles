#!/usr/bin/env bash
set -euo pipefail

# Install Bitwarden Desktop from official .deb (no snap)

cd /tmp
wget -qO bitwarden.deb "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb"

# Prefer apt-get to resolve dependencies automatically; fallback to dpkg + fix
sudo apt-get install -y ./bitwarden.deb || {
  sudo dpkg -i bitwarden.deb || true
  sudo apt-get -f install -y
}

rm -f bitwarden.deb
