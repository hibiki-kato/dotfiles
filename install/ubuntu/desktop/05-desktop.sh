#!/usr/bin/env zsh
set -euo pipefail

# Minimal X11 stack for CRD-only session on Ubuntu Desktop
# Keep local GNOME on Wayland as default; CRD uses its own Xorg session.

# Skip on WSL
if grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null; then
  exit 0
fi

sudo apt-get update -y || true

# --- (A) Xorg + 基本ツール（CRDがX11セッション立てるのに必要） ---
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  xorg \
  xauth \
  x11-xserver-utils \
  x11-apps \
  mesa-utils

# --- (B) 好みのX11対応DEを選ぶ（どちらか片方でOK） ---
# 1) Cinnamon（推奨：軽すぎずモダン）
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y cinnamon-core desktop-base

# 2) KDE Plasma（重めだが機能豊富）を使いたい場合はこちらを代わりに
# sudo DEBIAN_FRONTEND=noninteractive apt-get install -y plasma-desktop

# 3) Pantheon（Elementary OSのDE。軽量でモダン。ただしCRDでの相性は未知数）
# sudo add-apt-repository -y ppa:elementary-os/daily
# sudo add-apt-repository -y ppa:elementary-os/os-patches
# sudo apt-get update -y
# sudo DEBIAN_FRONTEND=noninteractive apt-get install -y elementary-desktop
