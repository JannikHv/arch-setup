#!/usr/bin/env bash

[[ $EUID -ne 0 ]] && root_flag="sudo" || root_flag=""

# Install dependencies
${root_flag} pacman -S --noconfirm --needed i3lock imagemagick scrot

# Copy content
${root_flag} cp ./src/blurlock.sh /usr/local/bin/blurlock
