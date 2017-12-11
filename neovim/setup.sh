#!/bin/sh

if [[ ${EUID} -eq 0 ]]; then
    echo "You can't be Root."
    exit 1
fi

# Install neovim and plugins
yaourt -S --noconfirm --needed neovim neovim-nerdtree xclip xsel

# Create necessary directories
mkdir -p ~/.config/nvim/
sudo mkdir -p /usr/share/nvim/runtime/syntax

# Copy files
cp -rf colors            ~/.config/nvim/
cp -f config/vimrc       ~/.config/nvim/init.vim
sudo cp -f syntax/c.vim  /usr/share/nvim/runtime/syntax
