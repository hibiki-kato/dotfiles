#!/usr/bin/env bash
set -euo pipefail

echo "Updating apt-get repositories..."

if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  echo "✓ apt-get repositories updated"
else
  echo "⚠ apt-get not found, skipping"
fi
