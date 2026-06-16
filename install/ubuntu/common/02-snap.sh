#!/usr/bin/env zsh
set -euo pipefail

# Install snap packages for Ubuntu.
if ! command -v snap >/dev/null 2>&1; then
  sudo apt-get update -y || true
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y snapd
fi

# Ensure snap is available.
if ! command -v snap >/dev/null 2>&1; then
  echo "snap not found; skipping snap installs" >&2
  return 0 2>/dev/null || exit 0
fi

# classic installs
classic_packages=(
  astral-uv
  yazi
)

for pkg in "${classic_packages[@]}"; do
  if snap list "$pkg" >/dev/null 2>&1; then
    echo "snap '$pkg' already installed"
  else
    echo "Installing snap '$pkg' (classic)..."
    sudo snap install --classic "$pkg"
  fi
done
