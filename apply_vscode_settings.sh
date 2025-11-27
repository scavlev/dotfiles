#!/bin/bash
# Merge VS Code shared settings with local settings

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SHARED_SETTINGS="$SCRIPT_DIR/dotfiles/vscode/shared-settings.json"
VSCODE_DIR="$HOME/.config/Code/User"
SETTINGS_FILE="$VSCODE_DIR/settings.json"

# Create VS Code directory if it doesn't exist
mkdir -p "$VSCODE_DIR"

# If settings.json doesn't exist, create an empty JSON object
if [ ! -f "$SETTINGS_FILE" ]; then
    echo "{}" > "$SETTINGS_FILE"
fi

# Merge shared settings into existing settings
# Shared settings take precedence over existing ones
jq -s '.[0] * .[1]' "$SETTINGS_FILE" "$SHARED_SETTINGS" > "$SETTINGS_FILE.tmp"
mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"

echo "✓ VS Code settings merged successfully"
