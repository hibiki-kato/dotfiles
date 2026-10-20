#!/usr/bin/env zsh
set -euo pipefail

app_id="org.openrgb.OpenRGB"
if ! flatpak info "$app_id" >/dev/null 2>&1; then
  flatpak install --system -y flathub "$app_id"
fi

# HardwareSync plugin runs nvidia-smi; expose the host's binary inside the sandbox
sudo flatpak override --system --filesystem=host-os:ro \
  --env=PATH=/app/bin:/usr/bin:/run/host/usr/bin "$app_id"

sudo install -d -m 755 /etc/udev/rules.d
flatpak run "$app_id" --print-udev-rules \
  | sudo tee /etc/udev/rules.d/60-openrgb.rules >/dev/null
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "OpenRGB installed; udev rules refreshed. Log out and back in if device access is denied."
