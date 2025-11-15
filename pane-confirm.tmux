#!/usr/bin/env bash

set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Unbind tmux's default kill-pane keybinding
tmux unbind -n x
tmux unbind x

# Bind x to our popup confirmation script
tmux bind-key x run-shell "$PLUGIN_DIR/scripts/confirm-close.sh"
