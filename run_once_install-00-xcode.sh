#!/bin/sh

if [ -d "$HOME/.local/share/chezmoi" ]; then
    # Chezmoi is already installed, so we can skip this step
    exit 0
fi

xcode-select --install || true
