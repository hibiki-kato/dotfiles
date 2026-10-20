#!/usr/bin/env zsh
set -euo pipefail

# Common prerequisites for Ubuntu installers
sudo apt-get update -y || true

if apt-cache policy nodejs 2>/dev/null | grep -q 'deb.nodesource.com'; then
  sudo DEBIAN_FRONTEND=noninteractive apt-get remove -y npm || true
fi

# Preseed Kerberos default realm so krb5-user installs non-interactively
echo 'krb5-config krb5-config/default_realm string UMD.EDU' | sudo debconf-set-selections

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  ca-certificates \
  curl \
  wget \
  unzip \
  gnupg \
  snapd \
  tmux \
  byobu \
  gpg \
  kmscon \
  fonts-noto-cjk \
  lsb-release \
  openssh-client \
  sshpass \
  krb5-user \
  software-properties-common \
  trash-cli \
  ripgrep \
  fzf \
  fd-find \
  bat \
  zoxide \
  w3m \
  chafa \
  rclone \
  imagemagick \
  ninja-build \
  gettext \
  cmake \
  zsh \
  zsh-syntax-highlighting \
  zsh-autosuggestions \
  btop \
  tree \
  cups cups-client lpr

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

if command -v npm >/dev/null 2>&1; then
  echo "npm available: $(npm --version)"
else
  echo "npm is not available after installing nodejs; skipping Ubuntu's npm package to avoid NodeSource dependency conflicts." >&2
fi
