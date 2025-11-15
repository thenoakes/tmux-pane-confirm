#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "${WEZTERM_PANE:-}" ]; then
  ENV_LINE="$(tmux show-environment -g WEZTERM_PANE 2>/dev/null || true)"
  case "$ENV_LINE" in
    WEZTERM_PANE=*)
      WEZTERM_PANE="${ENV_LINE#WEZTERM_PANE=}"
      ;;
  esac
fi

echo "wezterm_pane=${WEZTERM_PANE:-<unset>}" >> /tmp/confirm-debug.log

echo "running wezterm helper" >> /tmp/confirm-debug.log
if [ -n "${WEZTERM_PANE:-}" ]; then
  if "$SCRIPT_DIR/wezterm-confirm.sh" >/tmp/confirm-helper.log 2>&1; then
    echo "helper exited 0" >> /tmp/confirm-debug.log
    exit 0
  else
    status=$?
    echo "helper exit status $status" >> /tmp/confirm-debug.log
  fi
fi

echo "falling back to tmux popup" >> /tmp/confirm-debug.log

# Fallback to tmux's popup UI
tmux display-popup -w 40% -h 20% -E "$SCRIPT_DIR/popup-confirm.sh"
