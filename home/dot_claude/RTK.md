# RTK - Rust Token Killer

**Usage**: Token-optimized CLI proxy for reducing command-output tokens.

## Meta Commands

Always use `rtk` directly for:

```bash
rtk gain
rtk gain --history
rtk discover
rtk proxy <cmd>
```

## Installation Verification

```bash
rtk --version
rtk gain
which rtk
```

⚠️ **Name collision**: If `rtk gain` fails, you may have reachingforthejack/rtk (Rust Type Kit) installed instead.

## Hook-Based Usage

All other commands are automatically rewritten by the Claude Code hook.
Example: `git status` -> `rtk git status`.
