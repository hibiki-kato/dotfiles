#!/usr/bin/env bash
# 共通関数ライブラリ

has() { command -v "$1" >/dev/null 2>&1; }

is_macos()  { [[ "$(uname -s)" == "Darwin" ]]; }
is_linux()  { [[ "$(uname -s)" == "Linux"  ]]; }
is_ubuntu() { 
  [[ -f /etc/os-release ]] || return 1
  grep -Eq '^ID=ubuntu' /etc/os-release || grep -Eq '^ID_LIKE=.*ubuntu' /etc/os-release
}
is_debian() {
  [[ -f /etc/os-release ]] || return 1
  grep -Eq '^ID=debian' /etc/os-release || grep -Eq '^ID_LIKE=.*debian' /etc/os-release
}

# Ubuntu flavor detection
is_ubuntu_desktop() {
  is_ubuntu || return 1
  # Heuristics for desktop: XDG desktop env, graphical target, or ubuntu-desktop package
  [[ -n "${XDG_CURRENT_DESKTOP:-}" ]] && return 0
  systemctl get-default 2>/dev/null | grep -q 'graphical.target' && return 0
  dpkg -l 2>/dev/null | grep -Eq '^ii\s+ubuntu-desktop(-minimal)?\s' && return 0
  return 1
}

is_ubuntu_server() {
  is_ubuntu && ! is_ubuntu_desktop
}

# 指定ディレクトリ内の番号プレフィックス付きスクリプトを順次実行
run_scripts() {
  local dir="$1"; shift
  for num in "$@"; do
    for script in "$dir"/"$num"-*.sh; do
      [[ -f "$script" ]] || continue
      [[ -x "$script" ]] || chmod +x "$script"
      echo "→ Running: $(basename "$script")"
      "$script"
    done
  done
}

# スクリプトが存在すれば実行
run_if_exists() {
  local script="$1"
  [[ -f "$script" ]] || return 0
  [[ -x "$script" ]] || chmod +x "$script"
  echo "→ Running: $(basename "$script")"
  "$script"
}
