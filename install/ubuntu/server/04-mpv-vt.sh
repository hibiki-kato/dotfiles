#!/usr/bin/env zsh
set -euo pipefail

target_user="${SUDO_USER:-${USER:-}}"
if [[ -z "$target_user" || "$target_user" == "root" ]]; then
  target_user="$(logname 2>/dev/null || true)"
fi

if [[ -z "$target_user" || "$target_user" == "root" ]]; then
  echo "Could not determine the login user; skipping mpv-vt group setup." >&2
  exit 0
fi

missing=0
for cmd in mpv openvt chvt fgconsole runuser; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Missing command for mpv-vt: $cmd" >&2
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  echo "Install the Ubuntu server apt prerequisites before using mpv-vt." >&2
  exit 1
fi

for group_name in video render; do
  if ! getent group "$group_name" >/dev/null 2>&1; then
    echo "Group not present, skipping: $group_name"
    continue
  fi

  if id -nG "$target_user" | tr ' ' '\n' | grep -qx "$group_name"; then
    echo "$target_user is already in $group_name"
  else
    echo "Adding $target_user to $group_name"
    sudo usermod -aG "$group_name" "$target_user"
  fi
done

echo "mpv-vt setup complete. Existing shells may need a new login to see group changes."
