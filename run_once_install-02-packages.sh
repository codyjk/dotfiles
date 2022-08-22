#!/bin/bash

# starship prompt
~/.brew/bin/brew install starship

# nvm && node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# immediately load nvm so it's available in this session
. $HOME/.nvm/nvm.sh
nvm install node

# fzf (ignoring user prompts)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-bash --no-zsh --no-fish

# asdf
~/.brew/bin/brew install asdf

# ripgrep
brew install rg
