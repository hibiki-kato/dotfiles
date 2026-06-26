#!/usr/bin/env zsh
set -euo pipefail

if ! command -v cargo >/dev/null 2>&1; then
  echo "cargo is not available; skipping spotify_player." >&2
  exit 0
fi

cargo install spotify_player \
  --version 0.23.0 \
  --no-default-features \
  --features image,notify,media-control,pulseaudio-backend \
  --locked
