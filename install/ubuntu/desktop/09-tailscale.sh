#!/usr/bin/env zsh
set -euo pipefail

if command -v tailscale >/dev/null 2>&1; then
  echo "Tailscale already installed, skipping."
  exit 0
fi

OS_ID="$(. /etc/os-release && printf '%s' "$ID")"
CODENAME="$(lsb_release -cs)"

case "$OS_ID" in
  ubuntu|debian|raspbian)
    TAILSCALE_OS="$OS_ID"
    ;;
  *)
    echo "Unsupported OS for this Tailscale installer: $OS_ID" >&2
    exit 1
    ;;
esac

curl -fsSL "https://pkgs.tailscale.com/stable/${TAILSCALE_OS}/${CODENAME}.noarmor.gpg" \
  | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL "https://pkgs.tailscale.com/stable/${TAILSCALE_OS}/${CODENAME}.tailscale-keyring.list" \
  | sudo tee /etc/apt/sources.list.d/tailscale.list >/dev/null

sudo apt-get -y update
sudo apt-get -y install tailscale
