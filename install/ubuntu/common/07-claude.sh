#!/usr/bin/env zsh
set -euo pipefail

# Claude Code installer. Skip when the command is already available so this
# bootstrap can be re-run without reinstalling Claude every time.
if command -v claude >/dev/null 2>&1; then
	echo "Claude Code already installed, skipping."
	claude --version || true
	exit 0
fi

curl -fsSL https://claude.ai/install.sh | bash
