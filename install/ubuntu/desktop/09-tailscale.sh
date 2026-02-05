#!/bin/zsh
set -euo pipefail

# Get Ubuntu codename dynamically
UBUNTU_CODENAME=$(lsb_release -cs)

curl -fsSL "https://pkgs.tailscale.com/stable/ubuntu/${UBUNTU_CODENAME}.noarmor.gpg" | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL "https://pkgs.tailscale.com/stable/ubuntu/${UBUNTU_CODENAME}.tailscale-keyring.list" | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get -y update 
sudo apt-get -y install tailscale