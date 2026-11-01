#!/usr/bin/env zsh
set -euo pipefail

sudo apt-get update -y || true
sudo apt-get install -y fcitx5-mozc

# Plasma has a native Fcitx5 settings module. On Kubuntu 26.04, select Fcitx5
# as the virtual keyboard in System Settings after logging out and back in.
if dpkg-query -W -f='${Status}\n' plasma-desktop 2>/dev/null | grep -q 'install ok installed'; then
  sudo apt-get install -y kde-config-fcitx5
  # chezmoi manages ~/.xinputrc with run_im fcitx5. im-config refuses to
  # overwrite that file because its managed header changes the signature.
else
  # GNOME Tweaks is useful for keyboard options on GNOME, but does not
  # configure KDE Plasma.
  sudo apt-get install -y gnome-tweak-tool gnome-tweaks
fi
