#!/usr/bin/env zsh
set -euo pipefail

nextflow_bin="$HOME/.local/bin/nextflow"

if command -v nextflow >/dev/null 2>&1; then
  echo "Nextflow already installed, skipping."
  nextflow --version || true
  exit 0
fi

if [ -x "$nextflow_bin" ]; then
  echo "Nextflow already installed, skipping."
  "$nextflow_bin" --version || true
  exit 0
fi

mkdir -p "$(dirname "$nextflow_bin")"

# Reuse a binary left in the working directory if a previous run downloaded
# it but failed while installing it into a system directory.
if [ -x ./nextflow ]; then
  mv ./nextflow "$nextflow_bin"
else
  curl -fsSL https://get.nextflow.io | bash
  mv ./nextflow "$nextflow_bin"
fi

chmod 755 "$nextflow_bin"
echo "Nextflow installed at $nextflow_bin"
