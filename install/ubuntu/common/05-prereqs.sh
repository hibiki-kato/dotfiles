#!/usr/bin/env bash
set -euo pipefail

# Common prerequisites for Ubuntu installers
sudo apt-get update -y || true
sudo apt-get install -y \
  ca-certificates \
  curl \
  wget \
  gnupg \
  gpg \
  lsb-release \
  software-properties-common
