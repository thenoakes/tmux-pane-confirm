#!/usr/bin/env bash

set -euo pipefail

tmux display-menu \
  -T "#[align=centre]Close this pane?" \
  -x "#{pane_left}+#{pane_width}/2" \
  -y "#{pane_top}+3" \
  "" "" "" \
  "y" "Yes (Enter / Click)" "kill-pane" \
  "Enter" "Yes (Enter / Click)" "kill-pane" \
  "" "" "" \
  "n" "No (Esc / Click)" "" \
  "Escape" "No (Esc / Click)" ""
