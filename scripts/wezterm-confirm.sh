#!/usr/bin/env bash

set -euo pipefail

TMUX_TARGET="${TMUX_PANE:-}"
if [ -z "$TMUX_TARGET" ]; then
  TMUX_TARGET="$(tmux display-message -p '#{pane_id}' 2>/dev/null || true)"
fi
if [ -z "$TMUX_TARGET" ]; then
  exit 1
fi

PAYLOAD=$(cat <<EOF
{"pane_id":"$TMUX_TARGET"}
EOF
)
ENCODED=$(printf '%s' "$PAYLOAD" | base64 | tr -d '\n')

# Notify wezterm via OSC user var so it can render a native prompt
printf '\033]1337;SetUserVar=%s=%s\007' "tmux_pane_confirm" "$ENCODED"
