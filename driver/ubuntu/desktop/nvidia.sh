#!/usr/bin/env bash
set -euo pipefail

# Install the recommended NVIDIA proprietary driver for Ubuntu Desktop
# Non-interactive; suitable for chezmoi bootstrap.

if [[ $EUID -ne 0 ]]; then
  exec sudo -E bash "$0" "$@"
fi

# Failsafe 1: Check if NVIDIA GPU exists
if ! lspci | grep -i nvidia; then
  echo "No NVIDIA GPU detected; skipping driver installation." >&2
  exit 0
fi

# Failsafe 2: Check if NVIDIA driver is already installed and working
if command -v nvidia-smi >/dev/null 2>&1 && nvidia-smi >/dev/null 2>&1; then
  echo "NVIDIA driver already installed and working; skipping." >&2
  exit 0
fi

# Also check if driver package is already installed (even if not loaded yet)
if dpkg -l | grep -q '^ii.*nvidia-driver-[0-9]'; then
  echo "NVIDIA driver package already installed; skipping." >&2
  exit 0
fi

# Blacklist nouveau to prevent conflicts with proprietary NVIDIA driver
NOUVEAU_CONF="/etc/modprobe.d/blacklist-nouveau.conf"
if [[ ! -f "$NOUVEAU_CONF" ]]; then
  cat > "$NOUVEAU_CONF" <<EOF
blacklist nouveau
options nouveau modeset=0
EOF
  # Failsafe 3: Rollback nouveau blacklist if initramfs update fails
  if ! update-initramfs -u; then
    echo "Failed to update initramfs; rolling back nouveau blacklist." >&2
    rm -f "$NOUVEAU_CONF"
    exit 1
  fi
fi

# Ensure ubuntu-drivers is available
if ! command -v ubuntu-drivers >/dev/null 2>&1; then
  apt-get update -y
  apt-get install -y ubuntu-drivers-common
fi

# Detect recommended driver
DRIVER_PKG=$(ubuntu-drivers devices 2>/dev/null | awk '/recommended/ {print $3; exit}')
if [[ -z "${DRIVER_PKG:-}" ]]; then
  echo "No recommended NVIDIA driver found; skipping." >&2
  exit 0
fi

# Install driver + nvidia-settings (useful for desktops)
apt-get update -y

# Failsafe 4: Cleanup on driver installation failure
if ! DEBIAN_FRONTEND=noninteractive apt-get install -y "$DRIVER_PKG" nvidia-settings; then
  echo "Failed to install NVIDIA driver; attempting cleanup..." >&2
  apt-get autoremove -y || true
  apt-get autoclean -y || true
  # Optionally remove the blacklist if driver install failed
  if [[ -f "$NOUVEAU_CONF" ]]; then
    rm -f "$NOUVEAU_CONF"
    update-initramfs -u || true
  fi
  exit 1
fi