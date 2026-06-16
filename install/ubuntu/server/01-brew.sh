#!/usr/bin/env zsh
set -euo pipefail

export HOMEBREW_NO_SANDBOX_LINUX=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ASK=1

linuxbrew_prefix="/home/linuxbrew/.linuxbrew"
if ! command -v brew >/dev/null 2>&1 && [[ -x "${linuxbrew_prefix}/bin/brew" ]]; then
  eval "$("${linuxbrew_prefix}/bin/brew" shellenv zsh)"
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "brew is not available; skipping server Homebrew packages." >&2
  exit 0
fi

brew trust d99kris/nchat || true

brew install -y \
  chawan \
  meli

brew install -y d99kris/nchat/nchat --without-telegram
