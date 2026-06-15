#!/usr/bin/env zsh
set -euo pipefail

export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_SANDBOX_LINUX=1
export HOMEBREW_NO_ASK=1

linuxbrew_prefix="/home/linuxbrew/.linuxbrew"

append_once() {
  local line="$1"
  local file="$2"

  if ! grep -Fqx "$line" "$file" 2>/dev/null; then
    printf '\n%s\n' "$line" >> "$file"
  fi
}

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

append_once 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"' "$HOME/.zshrc"

brew install -y \
  zsh-autocomplete \
  zsh-history-substring-search \
  atuin \
  starship \
  glow

append_once 'source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh' "$HOME/.zshrc"
append_once 'eval "$(atuin init zsh)"' "$HOME/.zshrc"
append_once 'eval "$(starship init zsh)"' "$HOME/.zshrc"
eval "$(starship init zsh)"
