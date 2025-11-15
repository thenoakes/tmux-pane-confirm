# Unbind tmux's default kill-pane keybinding
unbind -n x
unbind x

# Bind x to our popup confirmation script using TPM's plugin dir
bind-key x run-shell "#{plugin_dir}/scripts/confirm-close.sh"
