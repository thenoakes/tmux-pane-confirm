# Unbind tmux's default kill-pane keybinding
unbind -n x
unbind x

# Bind x to our popup confirmation script
bind-key x run-shell "~/.tmux/plugins/tmux-pane-confirm/scripts/confirm-close.sh"
