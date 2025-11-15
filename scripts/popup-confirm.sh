#!/usr/bin/env bash
set -euo pipefail

# Clear screen and show prompt inside popup
cat <<'PROMPT'

   Close this pane?

   [y] Yes     [n] No

PROMPT

# Read a single keypress without echo
while IFS= read -rsn1 key; do
  case "$key" in
    y|Y)
      tmux kill-pane
      exit 0
      ;;
    n|N|$'\e'|q|Q)
      exit 0
      ;;
    *)
      # ignore other keys
      ;;
  esac
done
