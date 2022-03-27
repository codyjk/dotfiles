#!/bin/bash

~/.brew/bin/brew install vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# --sync - override default async plugin install behavior
# +qa - run :qa at the end
vim +'PlugInstall --sync' +qa
