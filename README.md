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

You will see a popup asking:

```
Close this pane?

[y] Yes     [n] No
```

## Requirements

- tmux 3.2 or later (popup support)
- TPM if installing as a plugin

## Optional: Native WezTerm UI

When tmux is running inside [WezTerm](https://wezfurlong.org/wezterm/), the plugin can request a richer confirmation dialog that supports mouse/touch input. Add this snippet to your `wezterm.lua`:

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

The plugin automatically falls back to the tmux popup when WezTerm is unavailable.
