#!/bin/bash

# neovim
~/.brew/bin/brew install neovim

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# nvm && node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# immediately load nvm so it's available in this session
. $HOME/.nvm/nvm.sh
nvm install node

# bun
curl -fsSL https://bun.sh/install | bash

# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# fzf (ignoring user prompts)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-bash --no-zsh --no-fish

# ripgrep
brew install rg

# powerlevel10k prompt
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# tmux
~/.brew/bin/brew install tmux

# git-lfs
~/.brew/bin/brew install git-lfs
