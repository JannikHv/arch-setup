#!/bin/sh

pkg_i3=("acpi" "playerctl" "alsa-utils" "feh" "pulseaudio" "pulseaudio-alsa" "cmus" "xorg-xprop" "rofi"
        "termite" "dropbox-cli" "networkmanager" "network-manager-applet" "compton" "xorg-xbacklight"
        "i3-gaps" "i3blocks" "i3lock" "i3status" "htop" "lxappearance" "arc-gtk-theme" "scrot" "imagemagick" "mupdf"
        "ranger" "mpv" "xbanish" "soundconverter")

# Burning utilities:
# brasero libburn libisofs dvdauthor vcdimager

echo -e "[\033[1;34m*\e[0m] Installing i3 related packages"
yaourt -S --noconfirm --needed ${pkg_i3[*]}
