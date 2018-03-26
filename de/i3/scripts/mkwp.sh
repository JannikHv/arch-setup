#!/bin/sh

if [ $EUID -eq 0 ]; then
    echo "You can't be root."
    exit 1
fi

if [ ! $1 ]; then
    exit 1
fi

rm -rf ~/.config/i3/wallpapers/*

cp "${1}" ~/.config/i3/wallpapers/Default
feh --bg-scale ~/.config/i3/wallpapers/Default*
