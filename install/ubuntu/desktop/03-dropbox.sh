#!/usr/bin/env bash
set -euo pipefail

# Install Dropbox for Ubuntu Desktop via official .deb package

DEB_URL="https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2025.05.20_amd64.deb"
DEB_FILE="/tmp/dropbox.deb"

# Download Dropbox .deb
wget -O "$DEB_FILE" "$DEB_URL"

# Install with apt (handles dependencies)
sudo apt-get install -y "$DEB_FILE" || {
  # Fallback to dpkg + fix dependencies
  sudo dpkg -i "$DEB_FILE" || true
  sudo apt-get install -f -y
}

# Cleanup
rm -f "$DEB_FILE"

# Note: Dropbox daemon will auto-start; first-time setup requires GUI login
echo "Dropbox installed. Launch 'dropbox start -i' to complete setup."