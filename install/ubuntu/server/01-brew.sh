#!/usr/bin/env zsh
set -euo pipefail

export HOMEBREW_NO_SANDBOX_LINUX=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ASK=1

brew trust normen/tap || true

brew install -y \
  chawan \
  normen/tap/whatscli
