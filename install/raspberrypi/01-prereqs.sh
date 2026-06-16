#!/usr/bin/env zsh
set -euo pipefail

# Lightweight base packages for Raspberry Pi OS.
sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  ca-certificates \
  cmake \
  curl \
  git \
  gnupg \
  gpg \
  htop \
  lsb-release \
  neovim \
  ninja-build \
  openssh-client \
  pkg-config \
  python3 \
  python3-pip \
  python3-venv \
  ripgrep \
  tmux \
  trash-cli \
  wget \
  zsh

# pi-apps
wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash

if apt-cache show pipx >/dev/null 2>&1; then
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y pipx
else
  echo "pipx package is not available in this apt repository; skipping."
fi
