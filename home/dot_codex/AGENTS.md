# Global rules

Prefer graph MCP tools for code discovery when available; fallback to grep/glob when unavailable or insufficient.

Use `rtk` for noisy command output when available. Use `rtk gain`, `rtk gain --history`, `rtk discover`, and `rtk proxy <cmd>` directly.

For non-trivial implementation: plan -> `agy-subagent "<task>"` -> review diff/tests.
Do not delegate architecture, security, or final judgment. Keep output compact.
