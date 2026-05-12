#!/bin/bash
set -e

RUNE_HOME="$HOME/.rune"
RUNE_BIN="$RUNE_HOME/bin"
RUNE_RUNES="$RUNE_HOME/runes"

REPO_URL="https://raw.githubusercontent.com/zeidle/rune/main"

echo "Installing Rune..."

mkdir -p "$RUNE_BIN"
mkdir -p "$RUNE_RUNES"

curl -fsSL "$REPO_URL/bin/rune" -o "$RUNE_BIN/rune"
chmod +x "$RUNE_BIN/rune"

SHELL_NAME="$(basename "$SHELL")"

if [ "$SHELL_NAME" = "zsh" ]; then
  SHELL_RC="$HOME/.zshrc"
elif [ "$SHELL_NAME" = "bash" ]; then
  SHELL_RC="$HOME/.bashrc"
else
  SHELL_RC="$HOME/.profile"
fi

PATH_LINE='export PATH="$HOME/.rune/bin:$PATH"'

if ! grep -q ".rune/bin" "$SHELL_RC" 2>/dev/null; then
  echo "" >> "$SHELL_RC"
  echo "# Rune" >> "$SHELL_RC"
  echo "$PATH_LINE" >> "$SHELL_RC"
fi

echo ""
echo "Rune installed."
echo ""
echo "Restart your terminal or run:"
echo "  source $SHELL_RC"
echo ""
echo "Then try:"
echo "  rune"
