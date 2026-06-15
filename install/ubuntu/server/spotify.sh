#!/usr/bin/env zsh
set -euo pipefail

if command -v spotify_player >/dev/null 2>&1; then
  echo "spotify_player already installed, skipping."
  exit 0
fi

brew install spotify_player
