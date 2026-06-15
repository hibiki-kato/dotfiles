#!/usr/bin/env zsh
set -euo pipefail

export HOMEBREW_NO_SANDBOX_LINUX=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ASK=1

if command -v spotify_player >/dev/null 2>&1; then
  echo "spotify_player already installed, skipping."
  exit 0
fi

brew install -y spotify_player
