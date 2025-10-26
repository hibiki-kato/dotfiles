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

# Documents / Downloads
ensure_link "$HOME/Documents" "$HOME/Library/CloudStorage/Dropbox/Documents"
ensure_link "$HOME/Downloads" "$HOME/Library/CloudStorage/Dropbox/Downloads"

# iPhone Backup
ensure_link "$HOME/Library/Application Support/MobileSync/Backup" \
            "$HOME/Library/CloudStorage/Dropbox/iPhone_Backup"

# chezmoi
ensure_link "$HOME/chezmoi" "$HOME/.local/share/chezmoi"