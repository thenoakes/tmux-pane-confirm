# tmux-pane-confirm

A tmux plugin that replaces `<prefix>-x` with a popup confirmation dialog (tmux 3.2+).

## Installation (TPM)

Add this to your `~/.tmux.conf`:

```
set -g @plugin 'thenoakes/tmux-pane-confirm'
```

Reload tmux:

```
prefix + I
```

## Usage

Press:

```
prefix + x
```

You will see a tmux overlay menu asking if you want to close the pane. Click on **Yes** or **No**, or press `y`/`Enter` for **Yes** and `n`/`Esc` for **No**.

## Requirements

- tmux 3.2 or later (popup support)
- TPM if installing as a plugin

## Optional: Native WezTerm UI (Experimental)

When tmux is running inside [WezTerm](https://wezfurlong.org/wezterm/), the plugin can emit a signal that WezTerm listens for to display its own confirmation dialog. This path is currently disabled by default until WezTerm exposes a richer modal popup API. To experiment with it, export `TMUX_PANE_CONFIRM_USE_WEZTERM=1` before starting tmux (or set the variable inside tmux), then add this snippet to your `wezterm.lua`:

```lua
local wezterm = require 'wezterm'

wezterm.on('user-var-changed', function(window, pane, name, value)
  if name ~= 'tmux_pane_confirm' then
    return
  end

  local data = wezterm.json_parse(value)

  window:perform_action(
    wezterm.action.InputSelector {
      description = 'Close this tmux pane?',
      choices = {
        { id = 'yes', label = 'Yes' },
        { id = 'no', label = 'No' },
      },
      action = wezterm.action_callback(function(_, _, id)
        if id == 'yes' then
          os.execute(string.format('tmux kill-pane -t %s', data.pane_id))
        end
      end),
    },
    pane
  )
end)
```

To allow the tmux server to see WezTerm's environment variables, the plugin appends `WEZTERM_PANE` to tmux's `update-environment` option. Reload tmux (or restart your tmux server) after installing so the server copies the variable from WezTerm; otherwise the plugin falls back to the tmux overlay menu.

The mouse-friendly tmux menu is always available, so you can safely leave the WezTerm integration disabled until a native popup API exists upstream.
