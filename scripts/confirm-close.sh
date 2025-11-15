#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -n "${WEZTERM_PANE:-}" ]; then
  if "$SCRIPT_DIR/wezterm-confirm.sh"; then
    exit 0
  fi
fi

# Fallback to tmux's popup UI
tmux display-popup -w 40% -h 20% -E "$SCRIPT_DIR/popup-confirm.sh"
