#!/usr/bin/env bash
set -euo pipefail

# Minimal X11 stack for Ubuntu Desktop (no display manager/DE)
# Installs Xorg server and basic X11 utilities

# Skip on WSL (no real X server expected by default)
if grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null; then
  exit 0
fi

sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  xorg \
  xinit \
  x11-apps \
  x11-xserver-utils \
  xauth \
  mesa-utils

# Set Xorg (X11) as default by disabling Wayland in display managers (idempotent)

# GDM3 (GNOME)
if dpkg -s gdm3 >/dev/null 2>&1 || systemctl status gdm3 >/dev/null 2>&1; then
  GDM_CONF="/etc/gdm3/custom.conf"
  sudo mkdir -p /etc/gdm3
  if [[ -f "$GDM_CONF" && ! -f "$GDM_CONF.bak" ]]; then
    sudo cp -a "$GDM_CONF" "$GDM_CONF.bak"
  fi
  if [[ ! -f "$GDM_CONF" ]]; then
    echo "[daemon]" | sudo tee "$GDM_CONF" >/dev/null
  fi
  grep -q '^\[daemon\]' "$GDM_CONF" 2>/dev/null || echo "[daemon]" | sudo tee -a "$GDM_CONF" >/dev/null
  if grep -q '^[#[:space:]]*WaylandEnable' "$GDM_CONF" 2>/dev/null; then
    sudo sed -i 's/^[#[:space:]]*WaylandEnable.*/WaylandEnable=false/' "$GDM_CONF"
  else
    echo "WaylandEnable=false" | sudo tee -a "$GDM_CONF" >/dev/null
  fi
fi

# SDDM (KDE)
if dpkg -s sddm >/dev/null 2>&1 || systemctl status sddm >/dev/null 2>&1; then
  SDDM_CONF="/etc/sddm.conf"
  if [[ -f "$SDDM_CONF" && ! -f "$SDDM_CONF.bak" ]]; then
    sudo cp -a "$SDDM_CONF" "$SDDM_CONF.bak"
  fi
  if grep -q '^\[General\]' "$SDDM_CONF" 2>/dev/null; then
    if grep -q '^[#[:space:]]*DisplayServer' "$SDDM_CONF" 2>/dev/null; then
      sudo sed -i 's/^[#[:space:]]*DisplayServer.*/DisplayServer=x11/' "$SDDM_CONF"
    else
      awk 'BEGIN{printed=0} /^\[General\]/{print;print "DisplayServer=x11"; printed=1; next} {print} END{if(!printed) print "[General]\nDisplayServer=x11"}' "$SDDM_CONF" | sudo tee "$SDDM_CONF.tmp" >/dev/null && sudo mv "$SDDM_CONF.tmp" "$SDDM_CONF"
    fi
  else
    printf "[General]\nDisplayServer=x11\n" | sudo tee -a "$SDDM_CONF" >/dev/null
  fi
fi

# Note: Do not restart display managers here; changes apply on next login/reboot.
