---
title: "Doppler Text-based UI (TUI) Guide"
description: "Master the Doppler Text-based UI for interactive terminal-based secrets management with navigation, editing, and configuration management features"
category: "cli"
type: "guide"
tags: ["doppler", "tui", "terminal", "interface", "interactive", "secrets-management"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler Text-based UI (TUI) Guide

## Overview

The Doppler Text-based UI (TUI) provides an interactive terminal interface for managing secrets, making it easier to navigate and edit configurations without remembering CLI commands.

## Launching the TUI

```bash
# Start the TUI in current directory
doppler tui

# Start with specific project/config
doppler tui --project api-service --config dev
```

## Interface Layout

The TUI is divided into three main sections:

```
┌─────────────────┬──────────────────┬────────────────────┐
│    CONFIGS      │    PROJECTS      │     SECRETS        │
│                 │                  │                    │
│ > dev           │   api-service    │ API_KEY    ******* │
│   staging       │   web-app        │ DATABASE   postgr..│
│   production    │   worker-service │ PORT       3000    │
└─────────────────┴──────────────────┴────────────────────┘
```

## Navigation

### Section Navigation
- `1` - Focus on Configs panel
- `2` - Focus on Projects panel  
- `3` - Focus on Secrets panel
- `Tab` - Cycle through panels
- `/` - Focus on filter/search

### Movement
- `j` or `↓` - Move cursor down
- `k` or `↑` - Move cursor up
- `h` or `←` - Move left (between name/value in secrets)
- `l` or `→` - Move right (between name/value in secrets)
- `g` - Go to top
- `G` - Go to bottom

### Actions
- `Enter` - Select item
- `Esc` - Cancel action/exit mode
- `q` - Quit TUI

## Secret Management

### Viewing Secrets
- Navigate to secrets panel with `3`
- Use `j/k` to move between secrets
- Use `h/l` to toggle between secret name and value
- Values are masked by default, press `Enter` to reveal

### Editing Secrets
1. Navigate to the secret you want to edit
2. Press `e` to enter edit mode
3. Modify the value
4. Press `Esc` to exit edit mode
5. Press `s` to save changes

### Adding New Secrets
1. Press `a` from the secrets panel
2. Enter the secret name
3. Press `Tab` to move to value field
4. Enter the secret value
5. Press `Enter` to confirm

### Deleting Secrets
1. Navigate to the secret
2. Press `d`
3. Confirm deletion when prompted

### Copying to Clipboard
1. Navigate to the secret value
2. Press `y` to copy to clipboard
3. A confirmation message will appear

## Filtering and Search

### Filter Secrets
1. Press `/` to focus on filter
2. Type your search term
3. Secrets list updates in real-time
4. Press `Esc` to clear filter

### Search Behavior
- Case-insensitive search
- Matches partial secret names
- Real-time filtering as you type

## Saving Changes

### Save Workflow
1. Make your changes (edit, add, or delete secrets)
2. Press `s` to open save prompt
3. Review changes in the confirmation dialog
4. Press `Enter` to confirm or `Esc` to cancel

### Unsaved Changes
- Modified secrets are marked with an indicator
- TUI warns before quitting with unsaved changes
- Use `Ctrl+C` to force quit without saving

## Advanced Features

### Multi-Select Operations
While not currently supported, future versions may include:
- Bulk secret operations
- Export selected secrets
- Mass visibility changes

### Keyboard Shortcuts Reference

| Key | Action |
|-----|--------|
| `1,2,3` | Focus panels |
| `j/k` | Navigate up/down |
| `h/l` | Navigate left/right |
| `e` | Edit mode |
| `a` | Add secret |
| `d` | Delete secret |
| `s` | Save changes |
| `y` | Copy to clipboard |
| `/` | Filter |
| `q` | Quit |
| `Esc` | Cancel/Exit mode |

## Tips and Best Practices

### Efficient Navigation
- Use number keys for quick panel switching
- Master vim-style navigation (hjkl) for speed
- Use `g` and `G` for quick jumps

### Safe Editing
- Always review changes before saving
- Use `Esc` liberally to cancel unwanted changes
- Keep original values in clipboard before editing

### Workflow Optimization
1. Start with filtering (`/`) to find secrets quickly
2. Use keyboard navigation instead of mouse
3. Group related edits and save once
4. Copy complex values before editing

## Limitations

> **Note**: "TUI may not contain all features available in the latest version of the Doppler CLI or the Doppler Dashboard."

Current limitations include:
- No secret referencing support
- Limited visibility controls
- No activity log viewing
- No service token management
- No advanced secret types (JSON editor)

## Common Use Cases

### Quick Secret Updates
```bash
# Launch TUI for production fixes
doppler tui --config production

# Navigate to secret, press 'e', update, 's' to save
```

### Development Configuration
```bash
# Use TUI for local development setup
doppler tui --config dev

# Add multiple secrets quickly with 'a'
```

### Secret Auditing
```bash
# Review all secrets in staging
doppler tui --config staging

# Use '/' to filter and check specific values
```

## Troubleshooting

### TUI Won't Start
- Ensure you're in a configured project directory
- Run `doppler setup` first if needed
- Check terminal compatibility

### Copy to Clipboard Not Working
- Ensure clipboard access is available
- Try different terminal emulators
- Use manual selection as fallback

### Display Issues
- Check terminal size (minimum 80x24 recommended)
- Try different color schemes
- Disable color with `--no-color` flag

## Integration with CLI

The TUI complements CLI usage:
```bash
# Use CLI for automation
doppler secrets set BULK_DATA < data.json

# Use TUI for interactive editing
doppler tui

# Verify with CLI
doppler secrets get BULK_DATA
```