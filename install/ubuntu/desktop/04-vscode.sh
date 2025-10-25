#!/usr/bin/env bash
set -euo pipefail

# Idempotent VS Code apt repo setup for Ubuntu
# - Places key in /etc/apt/keyrings/microsoft.gpg (644)
# - Writes a single canonical source list to /etc/apt/sources.list.d/vscode.list
# - Comments out duplicate/legacy entries to avoid "signed-by" conflict

ARCH=$(dpkg --print-architecture 2>/dev/null || echo amd64)
# Prefer existing keyring path to avoid conflicts between /etc and /usr/share
if [[ -e /usr/share/keyrings/microsoft.gpg ]]; then
  KEYRING="/usr/share/keyrings/microsoft.gpg"
elif [[ -e /etc/apt/keyrings/microsoft.gpg ]]; then
  KEYRING="/etc/apt/keyrings/microsoft.gpg"
else
  KEYRING="/etc/apt/keyrings/microsoft.gpg"
fi
LIST_FILE="/etc/apt/sources.list.d/vscode.list"
REPO_LINE="deb [arch=${ARCH} signed-by=${KEYRING}] https://packages.microsoft.com/repos/code stable main"

# Ensure keyrings dir exists (for whichever path we chose)
sudo install -d -m 755 "$(dirname "$KEYRING")"

# Install/refresh Microsoft GPG key (atomic write)
TMPKEY=$(mktemp)
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > "$TMPKEY"
sudo install -m 644 "$TMPKEY" "$KEYRING"
rm -f "$TMPKEY"

# Write canonical repo file (overwrite to keep single definition)
echo "$REPO_LINE" | sudo tee "$LIST_FILE" >/dev/null

# Comment out any duplicate code repo definitions elsewhere to avoid option conflicts
for f in /etc/apt/sources.list /etc/apt/sources.list.d/*.list; do
  # Skip our canonical file and non-existent globs
  [[ -e "$f" ]] || continue
  [[ "$f" == "$LIST_FILE" ]] && continue
  if grep -qE 'https://packages.microsoft.com/.*/code' "$f" 2>/dev/null; then
    sudo sed -i 's@^\s*deb\s\+\(.*packages.microsoft.com.*/code.*\)@# \0@g' "$f" || true
  fi
done

sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y code