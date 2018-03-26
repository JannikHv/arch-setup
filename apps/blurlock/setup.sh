#!/usr/bin/env bash

[[ $EUID -ne 0 ]] && root_flag="sudo" || root_flag=""

# Install dependencies
${root_flag} pacman -S --noconfirm --needed i3lock imagemagick scrot

# Remove content if exists
rm -rf "/usr/local/bin/blurlock"

# Copy content
${root_flag} ln -s "$(pwd)/src/blurlock.sh" "/usr/local/bin/blurlock"
