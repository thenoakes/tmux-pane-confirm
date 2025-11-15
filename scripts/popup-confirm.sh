#!/usr/bin/env bash

set -euo pipefail

tmux display-menu \
  -T "#[align=centre]Close this pane?" \
  -x P \
  -y 1 \
  "" "" "" \
  "y" "Yes (Enter / Click)" "kill-pane" \
  "Enter" "Yes (Enter / Click)" "kill-pane" \
  "" "" "" \
  "n" "No (Esc / Click)" "" \
  "Escape" "No (Esc / Click)" ""
