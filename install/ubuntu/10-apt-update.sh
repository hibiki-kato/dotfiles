#!/usr/bin/env bash
set -euo pipefail

echo "Updating apt repositories..."

if command -v apt >/dev/null 2>&1; then
  sudo apt update
  echo "✓ apt repositories updated"
else
  echo "⚠ apt not found, skipping"
fi
