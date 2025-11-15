#!/usr/bin/env bash

set -euo pipefail

# Ensure wezterm CLI is available before attempting to trigger UI
if ! command -v wezterm >/dev/null 2>&1; then
  exit 1
fi

TMUX_TARGET="${TMUX_PANE:-}"
if [ -z "$TMUX_TARGET" ]; then
  exit 1
fi

PAYLOAD=$(printf '{"pane_id":"%s"}' "$TMUX_TARGET")
ENCODED=$(printf '%s' "$PAYLOAD" | base64 | tr -d '\n')

# Notify wezterm via OSC user var so it can render a native prompt
printf '\033]1337;SetUserVar=%s=%s\007' "tmux_pane_confirm" "$ENCODED"
