#!/usr/bin/env bash

set -euo pipefail

TMUX_TARGET="${TMUX_PANE:-}"
if [ -z "$TMUX_TARGET" ]; then
  TMUX_TARGET="$(tmux display-message -p '#{pane_id}' 2>/dev/null || true)"
fi
if [ -z "$TMUX_TARGET" ]; then
  exit 1
fi

PAYLOAD=$(cat <<PAYLOAD_JSON
{"pane_id":"$TMUX_TARGET"}
PAYLOAD_JSON
)
ENCODED=$(printf '%s' "$PAYLOAD" | base64 | tr -d '\n')

CLIENT_TTY="$(tmux display-message -p -t "$TMUX_TARGET" '#{client_tty}' 2>/dev/null || true)"
if [ -z "$CLIENT_TTY" ] || [ ! -w "$CLIENT_TTY" ]; then
  exit 1
fi

printf '\033]1337;SetUserVar=%s=%s\007' 'tmux_pane_confirm' "$ENCODED" >"$CLIENT_TTY"
