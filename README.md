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
