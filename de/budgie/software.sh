#!/bin/sh

pkg_gnome=("adwaita-icon-theme" "eog" "evince" "gnome-calculator" "gnome-contacts" "gnome-terminal"
           "gnome-control-center" "gnome-screenshot" "gnome-session" "budgie-desktop"
           "gnome-settings-daemon" "gnome-system-monitor"
           "gnome-themes-standard" "gvfs" "gvfs-afc" "gvfs-goa" "gvfs-google" "gvfs-mtp" "gvfs-nfs"
           "mousetweaks" "nautilus" "nautilus-dropbox" "networkmanager" "totem" "gedit"
           "xdg-user-dirs-gtk" "network-manager-applet" "rhythmbox" "mpv" "nodejs" "electron" "vlc"
           "gtk-arc-flatabulous-theme-git" "paper-icon-theme")

echo -e "[\033[1;34m*\e[0m] Installing gnome related packages"
yaourt -S --noconfirm --needed ${pkg_gnome[*]}
