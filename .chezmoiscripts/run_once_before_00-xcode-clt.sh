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
# Give up after 30 minutes, e.g. if the install dialog was cancelled.
waited=0
while ! xcode-select -p >/dev/null 2>&1; do
    if [ "$waited" -ge 1800 ]; then
        echo "XCode Command Line Tools did not install. Run 'xcode-select --install', then 'chezmoi apply'." >&2
        exit 1
    fi
    sleep 5
    waited=$((waited + 5))
done

echo "✓ XCode Command Line Tools installed successfully"
