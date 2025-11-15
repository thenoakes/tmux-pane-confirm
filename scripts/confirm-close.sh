#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

WEZTERM_PANE_ID="${WEZTERM_PANE:-}"

# Prefer WezTerm-native UX when possible
if [ -n "$WEZTERM_PANE_ID" ]; then
  if "$SCRIPT_DIR/wezterm-confirm.sh"; then
    exit 0
  fi
fi

# Fallback to tmux's popup UI
tmux display-popup -w 40% -h 20% -E "$SCRIPT_DIR/popup-confirm.sh"
