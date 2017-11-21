#!/bin/sh

if [[ ${EUID} -eq 0 ]]; then
    echo "You can't be Root."
    exit 1
fi

# i3
rm -f   ~/.config/i3/config
rm -rf  ~/.config/i3/modules
sudo rm /etc/i3blocks.conf

mkdir -p ~/.config/i3
mkdir -p ~/.config/i3/wallpapers

cp -f      "config/i3-config"       ~/.config/i3/config
cp -rf     "config/modules"         ~/.config/i3/modules
sudo cp -f "config/i3blocks.conf"   /etc/i3blocks.conf

# termite
sudo rm -f /etc/xdg/termite/config

sudo mkdir -p /etc/xdg/termite

sudo cp    "config/termite-config" /etc/xdg/termite/config

# xorg
rm -f ~/.xinitrc
rm -f ~/.Xresources

cp "config/xinitrc"     ~/.xinitrc
cp "config/Xresources"  ~/.Xresources
