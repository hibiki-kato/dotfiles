#!/usr/bin/env zsh
set -euo pipefail

if command -v nextflow >/dev/null 2>&1; then
  echo "Nextflow already installed, skipping."
  nextflow --version || true
  exit 0
fi

curl -fsSL https://get.nextflow.io | bash
mv nextflow /usr/local/bin/