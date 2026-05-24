#!/usr/bin/env zsh
set -euo pipefail

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is required for rustdesk-server. Run 02-docker.sh first." >&2
  exit 1
fi

sudo mkdir -p /opt/rustdesk-server
cd /opt/rustdesk-server

if [ ! -f compose.yml ]; then
  sudo wget rustdesk.com/oss.yml -O compose.yml
else
  echo "RustDesk server compose.yml already exists, keeping it."
fi

sudo docker compose up -d
