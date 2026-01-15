#!/bin/sh

set -e  # Exit on error

# Check if Homebrew is already installed at custom location
if [ -d "$HOME/.brew" ]; then
    echo "✓ Homebrew already installed at ~/.brew, skipping..."
    exit 0
fi

echo "Installing Homebrew to ~/.brew..."
git clone --depth=1 https://github.com/Homebrew/brew ~/.brew

# Verify installation
if [ -x "$HOME/.brew/bin/brew" ]; then
    echo "✓ Homebrew installed successfully"
else
    echo "❌ Homebrew installation failed"
    exit 1
fi
