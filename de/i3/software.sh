#!/bin/sh

pkg_i3=("acpi" "playerctl" "alsa-utils" "feh" "i3" "pulseaudio" "pulseaudio-alsa" "rhythmbox" "xorg-xprop"
        "termite" "dropbox-cli" "vlc" "qt4" "networkmanager" "network-manager-applet" "compton" "rofi" "xorg-xbacklight")

echo -e "[\033[1;34m*\e[0m] Installing i3 related packages"
yaourt -S --noconfirm --needed ${pkg_i3[*]}
