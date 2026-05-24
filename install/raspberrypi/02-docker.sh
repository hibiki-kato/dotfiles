#!/usr/bin/env zsh
set -euo pipefail

if command -v docker >/dev/null 2>&1; then
  echo "Docker already installed, skipping."
else
  bash <(wget -qO- https://get.docker.com)
fi

if getent group docker >/dev/null 2>&1; then
  sudo usermod -aG docker "$USER" || true
fi

sudo docker version >/dev/null
sudo docker compose version >/dev/null
