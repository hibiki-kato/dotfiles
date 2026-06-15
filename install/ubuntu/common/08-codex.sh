#!/usr/bin/env zsh
set -euo pipefail

# Codex installer. Skip when the command is already available so this bootstrap
# can be re-run without reinstalling Codex every time.
if command -v codex >/dev/null 2>&1; then
	echo "Codex already installed, skipping."
	codex --version || true
	exit 0
fi

curl -fsSL https://chatgpt.com/codex/install.sh | CODEX_NON_INTERACTIVE=1 sh
