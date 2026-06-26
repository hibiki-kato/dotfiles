#!/usr/bin/env zsh
set -euo pipefail

export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_SANDBOX_LINUX=1
export HOMEBREW_NO_ASK=1

linuxbrew_prefix="/home/linuxbrew/.linuxbrew"

sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  bubblewrap \
  curl \
  file \
  git

if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
  if [[ -x "${linuxbrew_prefix}/bin/brew" ]]; then
    eval "$("${linuxbrew_prefix}/bin/brew" shellenv zsh)"
  else
    echo "Homebrew install must run as the target user, not root. Re-run chezmoi as the normal user." >&2
    exit 1
  fi
fi

if ! command -v brew >/dev/null 2>&1; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v brew >/dev/null 2>&1 && [ -x "${linuxbrew_prefix}/bin/brew" ]; then
  eval "$("${linuxbrew_prefix}/bin/brew" shellenv zsh)"
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "brew was not found after Homebrew installation" >&2
  exit 1
fi

brew install -y \
  zsh-autocomplete \
  zsh-history-substring-search \
  atuin \
  starship \
  glow \
  tree-sitter-cli \
  antigravity-cli
