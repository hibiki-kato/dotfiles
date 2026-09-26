#!/usr/bin/env zsh
set -euo pipefail

if command -v sunshine >/dev/null 2>&1; then
  echo "Sunshine already installed, skipping."
  exit 0
fi

curl -1sLf 'https://dl.cloudsmith.io/public/lizardbyte/stable/cfg/setup/bash.deb.sh' \
  | sudo -E bash
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y sunshine
