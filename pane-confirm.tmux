#!/usr/bin/env bash

set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ensure_update_environment_var() {
    local var="$1"
    local current
    current="$(tmux show-option -gqv update-environment 2>/dev/null || true)"
    case " $current " in
        *" $var "*) ;;
        *)
            tmux set-option -ga update-environment " $var"
            ;;
    esac
}

ensure_update_environment_var "WEZTERM_PANE"

# Unbind tmux's default kill-pane keybinding
tmux unbind -n x
tmux unbind x

# Bind x to our popup confirmation script
tmux bind-key x run-shell "$PLUGIN_DIR/scripts/confirm-close.sh"
