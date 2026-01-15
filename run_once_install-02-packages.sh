#!/bin/bash

set -e  # Exit on error

echo "=== Installing development packages ==="
echo

# Add brew to PATH for this script
export PATH="$HOME/.brew/bin:$PATH"

# ============================================================================
# RUST (Install FIRST - needed for ripgrep to build from source)
# ============================================================================
if command -v rustc >/dev/null 2>&1; then
    echo "✓ Rust already installed, skipping..."
else
    echo "Installing Rust toolchain..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    # Load rust into current shell
    source "$HOME/.cargo/env"
    echo "✓ Rust installed successfully"
fi
echo

# ============================================================================
# HOMEBREW PACKAGES (via Brewfile)
# ============================================================================
if [ -f "$HOME/.Brewfile" ]; then
    echo "Installing Homebrew packages from Brewfile..."
    if ! command -v brew >/dev/null 2>&1; then
        echo "❌ Homebrew not found in PATH"
        exit 1
    fi
    brew bundle install --file="$HOME/.Brewfile" --no-lock
    echo "✓ Homebrew packages installed"
else
    echo "⚠️  Brewfile not found at $HOME/.Brewfile, skipping Homebrew packages"
fi
echo

# ============================================================================
# NVM & NODE
# ============================================================================
if [ -d "$HOME/.nvm" ]; then
    echo "✓ NVM already installed, skipping..."
else
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    echo "✓ NVM installed"
fi

# Load nvm if not already loaded
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"

    # Install node if not present
    if ! command -v node >/dev/null 2>&1; then
        echo "Installing Node.js..."
        nvm install node
        echo "✓ Node.js installed"
    else
        echo "✓ Node.js already installed, skipping..."
    fi
else
    echo "⚠️  NVM installation may have failed - nvm.sh not found"
fi
echo

# ============================================================================
# PYENV
# ============================================================================
if [ -d "$HOME/.pyenv" ]; then
    echo "✓ pyenv already installed, skipping..."
else
    echo "Installing pyenv..."
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    echo "✓ pyenv installed"
    echo "ℹ️  Run 'pyenv install 3.x.x' to install a Python version"
fi
echo

# ============================================================================
# FZF (with shell integration enabled)
# ============================================================================
if [ -d "$HOME/.fzf" ]; then
    echo "✓ fzf already installed, skipping..."
else
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    # Install with zsh integration enabled (removes --no-zsh flag)
    ~/.fzf/install --key-bindings --completion --no-update-rc
    echo "✓ fzf installed"
fi
echo

# ============================================================================
# POWERLEVEL10K
# ============================================================================
if [ -d "$HOME/powerlevel10k" ]; then
    echo "✓ powerlevel10k already installed, skipping..."
else
    echo "Installing powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    echo "✓ powerlevel10k installed"
fi
echo

echo "=== ✓ All packages installed successfully ==="
echo
echo "Next steps:"
echo "  1. Restart your terminal or run: exec \$SHELL -l"
echo "  2. Install a Python version: pyenv install 3.12.1"
echo "  3. Configure your editor and start coding!"
