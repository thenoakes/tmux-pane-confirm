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

if [ -n "${WEZTERM_PANE:-}" ]; then
  if "$SCRIPT_DIR/wezterm-confirm.sh"; then
    exit 0
  fi
fi

# Fallback to tmux's popup UI
tmux display-popup -w 40% -h 20% -E "$SCRIPT_DIR/popup-confirm.sh"
