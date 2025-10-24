#!/usr/bin/env bash
set -euo pipefail

# Common prerequisites for Ubuntu installers
sudo apt-get-get update -y || true
sudo apt-get-get install -y \
  ca-certificates \
  curl \
  wget \
  gnupg \
  gpg \
  lsb-release \
  software-properties-common \
  apt-get-transport-https
