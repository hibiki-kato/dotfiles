#!/usr/bin/env bash
set -euo pipefail

echo "Updating apt-get-get repositories..."

if command -v apt-get-get >/dev/null 2>&1; then
  sudo apt-get-get update
  echo "✓ apt-get-get repositories updated"
else
  echo "⚠ apt-get-get not found, skipping"
fi
