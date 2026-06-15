#!/usr/bin/env zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
"$SCRIPT_DIR/../ubuntu/common/10-tailscale.sh"
