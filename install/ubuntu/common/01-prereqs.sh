#!/usr/bin/env zsh
set -euo pipefail

# Common prerequisites for Ubuntu installers
sudo apt-get update -y || true
sudo apt-get install -y \
  build-essential \
  ca-certificates \
  curl \
  wget \
  gnupg \
  gpg \
  lsb-release \
  openssh-client \
  software-properties-common \
  flatpak \
  redshift