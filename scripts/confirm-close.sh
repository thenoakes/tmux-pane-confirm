#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Show popup with confirmation UI script
tmux display-popup -w 40% -h 20% -E "$SCRIPT_DIR/popup-confirm.sh"
