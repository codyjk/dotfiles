#!/bin/sh

set -e  # Exit on error

# Check if XCode Command Line Tools are already installed
if xcode-select -p >/dev/null 2>&1; then
    echo "✓ XCode Command Line Tools already installed, skipping..."
    exit 0
fi

echo "Installing XCode Command Line Tools..."
echo "⚠️  A GUI dialog will appear - please click 'Install'"

# Start installation
xcode-select --install 2>/dev/null || true

# Wait for installation to complete
echo "Waiting for XCode Command Line Tools installation to complete..."
while ! xcode-select -p >/dev/null 2>&1; do
    sleep 5
done

echo "✓ XCode Command Line Tools installed successfully"
