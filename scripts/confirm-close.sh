#!/usr/bin/env bash

# Popup confirmation dialog for killing the pane
tmux display-popup -E '
  echo "";
  echo "   Close this pane?";
  echo "";
  echo "   [y] Yes     [n] No";
  echo "";
  read -n 1 key;
  if [ "$key" = "y" ] || [ "$key" = "Y" ]; then
    tmux kill-pane
  fi
' -w 40% -h 20%
