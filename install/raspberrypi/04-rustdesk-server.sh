#!/usr/bin/env zsh
set -euo pipefail

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is required for rustdesk-server. Run 03-docker.sh first." >&2
  exit 1
fi

SCRIPT_DIR="${0:A:h}"
"$SCRIPT_DIR/../../scripts/raspberrypi/rustdesk-server.sh" setup
