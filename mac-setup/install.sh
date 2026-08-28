#!/bin/bash
set -euo pipefail

# kopus Mac-side setup
# Installs the opencode plugin that emits a terminal bell (BEL) when an opencode
# job becomes idle ("done"), which the kopus app on the phone hears and answers
# with a relaxing chime.

PLUGIN_DIR="$HOME/.config/opencode/plugins"
PLUGIN_SRC="$(cd "$(dirname "$0")" && pwd)/kopus-bell.js"
PLUGIN_DEST="$PLUGIN_DIR/kopus-bell.js"

if [ ! -d "$PLUGIN_DIR" ]; then
  mkdir -p "$PLUGIN_DIR"
  echo "Created $PLUGIN_DIR"
fi

cp "$PLUGIN_SRC" "$PLUGIN_DEST"
echo "Installed $PLUGIN_DEST"

echo ""
echo "Done. The bell plugin is active for all future opencode sessions."
echo ""
echo "If the TUI swallows the bell (you hear nothing on the phone), the fallback"
echo "is a wrapper command. Add this to your shell profile (~/.zshrc):"
echo ""
echo "  oc() { opencode \"\$@\"; printf '\\a'; }"
echo ""
echo "and run jobs with 'oc' instead of 'opencode'."