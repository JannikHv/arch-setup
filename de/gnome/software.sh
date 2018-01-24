#!/bin/sh

pkg_gnome=("adwaita-icon-theme" "eog" "evince" "gnome-calculator" "gnome-contacts"
           "gnome-control-center" "gnome-screenshot" "gnome-session" "gnome-tweak-tool"
           "gnome-settings-daemon" "gnome-shell" "gnome-shell-extensions" "gnome-system-monitor"
           "gnome-themes-standard" "gvfs" "gvfs-afc" "gvfs-goa" "gvfs-google" "gvfs-mtp" "gvfs-nfs"
           "mousetweaks" "mutter" "nautilus" "nautilus-dropbox" "networkmanager" "totem"
           "xdg-user-dirs-gtk" "network-manager-applet" "rhythmbox" "mpv" "nodejs" "electron" "vlc"
           "gnome-shell-extension-dash-to-dock" "gnome-shell-extension-no-topleft-hot-corner"
           "gnome-shell-extension-topicons-plus"
           "gtk-arc-flatabulous-theme-git" "paper-icon-theme")

echo -e "[\033[1;34m*\e[0m] Installing gnome related packages"
yaourt -S --noconfirm --needed ${pkg_gnome[*]}
