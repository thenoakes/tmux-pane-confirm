#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

USE_WEZTERM="${TMUX_PANE_CONFIRM_USE_WEZTERM:-0}"

# TODO: re-enable WezTerm native dialog once WezTerm exposes richer modal APIs.
if [ "$USE_WEZTERM" = "1" ]; then
  if [ -z "${WEZTERM_PANE:-}" ]; then
    ENV_LINE="$(tmux show-environment -g WEZTERM_PANE 2>/dev/null || true)"
    case "$ENV_LINE" in
      WEZTERM_PANE=*)
        WEZTERM_PANE="${ENV_LINE#WEZTERM_PANE=}"
        ;;
    esac
  fi

  if [ -n "${WEZTERM_PANE:-}" ] && "$SCRIPT_DIR/wezterm-confirm.sh"; then
    exit 0
  fi
fi

"$SCRIPT_DIR/popup-confirm.sh"
