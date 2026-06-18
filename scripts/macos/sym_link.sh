#!/bin/zsh
set -euo pipefail

open "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"

ensure_link() {
  local link="$1" target="$2"
  if [ -L "$link" ]; then # シンボリックリンクの場合
    local cur; cur="$(readlink "$link" || true)"
    [ "$cur" = "$target" ] && return 0 # 既に正しいリンクなら何もしない
    sudo command rm -f -- "$link" # 違うリンクなら削除
  elif [ -e "$link" ]; then # 実体が存在する場合
    sudo mv -- "$link" "$link.bak.$(date +%Y%m%d-%H%M%S)" # バックアップを作成してから削除
  fi
  ln -s -- "$target" "$link" # 新しいシンボリックリンクを作成
}

# Dropbox ルート
ensure_link "$HOME/Dropbox" "$HOME/Library/CloudStorage/Dropbox"

# Documents
ensure_link "$HOME/Documents" "$HOME/Library/CloudStorage/Dropbox/Documents"

# iPhone Backup
ensure_link "$HOME/Library/Application Support/MobileSync/Backup" \
            "$HOME/Library/CloudStorage/Dropbox/iPhone_Backup"

# chezmoi
ensure_link "$HOME/chezmoi" "$HOME/.local/share/chezmoi"

# overwride gcc with genuine gnu gcc
_gcc_bin=$(ls /opt/homebrew/bin/gcc-[0-9]* 2>/dev/null | sort -t- -k2 -V | tail -1)
_gxx_bin=$(ls /opt/homebrew/bin/g++-[0-9]* 2>/dev/null | sort -t- -k2 -V | tail -1)
if [[ -n "$_gcc_bin" && -n "$_gxx_bin" ]]; then
  sudo ln -sf "$_gcc_bin" /usr/local/bin/gcc
  sudo ln -sf "$_gxx_bin" /usr/local/bin/g++
else
  echo "Warning: Homebrew gcc not found, skipping cpp symlinks" >&2
fi
unset _gcc_bin _gxx_bin

# java
ensure_link $ sudo ln -sfn $(brew --prefix)/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk