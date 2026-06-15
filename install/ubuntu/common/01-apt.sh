#!/usr/bin/env zsh
set -euo pipefail

# Common prerequisites for Ubuntu installers
sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  ca-certificates \
  curl \
  wget \
  unzip \
  gnupg \
  snapd \
  tmux \
  gpg \
  lsb-release \
  openssh-client \
  software-properties-common \
  trash-cli \
  ripgrep \
  fzf \
  fd-find \
  bat \
  zoxide \
  w3m \
  chafa \
  imagemagick \
  nodejs \
  npm \
  neovim \
  zsh \
  zsh-syntax-highlighting \
  zsh-autosuggestions
