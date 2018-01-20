#!/bin/sh

if [[ ${EUID} -eq 0 ]]; then
    echo "You can't be Root."
    exit 1
fi

# Create directories if no existing
mkdir -p      ~/.config/i3/{wallpapers,modules,scripts}
sudo mkdir -p /etc/xdg/termite/

# Update files
sudo cp -f "config/i3blocks-bw.conf"     "/etc/i3blocks.conf"
sudo cp -f "config/termite-config"       "/etc/xdg/termite/config"
cp -f      "config/i3-config"            "${HOME}/.config/i3/config"
cp -f      "config/xinitrc"              "${HOME}/.xinitrc"
cp -f      "config/Xresources"           "${HOME}/.Xresources"
cp -rfT    "modules"                     "${HOME}/.config/i3/modules"
cp -rfT    "scripts"                     "${HOME}/.config/i3/scripts"
cp -f      "wallpapers/"*                "${HOME}/.config/i3/wallpapers/Default.png"
