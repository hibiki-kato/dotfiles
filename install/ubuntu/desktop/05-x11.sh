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
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y plasma-desktop

# --- (C) CRDセッションをこのDEで起動させる設定 ---
# Cinnamon の X11 セッション
echo 'exec /etc/X11/Xsession /usr/bin/cinnamon-session-cinnamon2d' | sudo tee /etc/chrome-remote-desktop-session >/dev/null

# KDE Plasma の場合は上行の代わりに以下
echo 'exec /usr/bin/startplasma-x11' | sudo tee /etc/chrome-remote-desktop-session >/dev/null

# パーミッション念のため
sudo chmod 644 /etc/chrome-remote-desktop-session

# --- (D) 余計なことはしない：Waylandはデフォルトのまま ---
# ※ gdm3/sddm の Wayland/Xorg 切替は一切触らない
#   /etc/gdm3/custom.conf の WaylandEnable=false を入れない/消しておく
if [ -f /etc/gdm3/custom.conf ]; then
  sudo sed -i '/^[[:space:]]*WaylandEnable[[:space:]]*=/d' /etc/gdm3/custom.conf || true
fi

# --- (E) ユーザーをCRDグループに（未設定なら） ---
if id -nG "$USER" 2>/dev/null | grep -qv '\bchrome-remote-desktop\b'; then
  sudo usermod -a -G chrome-remote-desktop "$USER"
  echo ">>> Re-login needed for chrome-remote-desktop group to take effect."
fi

echo "CRD will start an Xorg session with KDE. Local GNOME stays on Wayland."