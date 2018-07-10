#!/bin/sh

if [[ $EUID -eq 0 ]]; then
    echo "You can't be Root."
    exit 1
fi

if ! pacman -Q yaourt &> /dev/null; then
    echo "Yaourt is not installed."
    exit 1
fi

pkg_lst=("xorg-server" "xorg-xinit" "xf86-input-mouse" "xf86-input-keyboard" "xf86-input-libinput"
         "xf86-input-synaptics" "xorg-xrandr" "downgrade" "xdotool" "rsync" "xdg-user-dirs"
         "xdg-user-dirs-gtk" "xdg-utils"
         
         "easytag" "gimp" "dropbox" "dropbox-cli" "google-chrome"

         "brasero" "libburn" "libisofs" "dvdauthor" "vcdimager"
         
         "ttf-liberation" "ttf-roboto" "ttf-ubuntu-font-family" "ttf-dejavu" "cantarell-fonts"
         "ttf-hack" "ttf-roboto-mono" "ttf-opensans ttf-font-awesome-4"
         
         "curl" "git" "wget" "youtube-dl" "zip" "unzip" "tar" "gptfdisk" "pkg-config" "openssh" "whois"
         
         "aircrack-ng" "reaver" "hydra" "arp-scan" "dsniff" "ettercap" "nmap"

         "sassc" "inotify-tools" "htop"
         
         "gst-plugins-ugly" "gst-plugins-good" "gst-libav" "gvfs" "gvfs-mtp" "gvfs-afc" "gvfs-goa"
         "gvfs-google" "gvfs-nfs" "gvfs-smb" "libappindicator-gtk2"
         "libappindicator-gtk3" "libappindicator-sharp"
         
         "xcursor-vanilla-dmz"
         
         "hplip" "cups" "cups-pdf")

echo -e "[\033[1;34m*\e[0m] Installing default software"
yaourt -S --noconfirm --needed ${pkg_lst[*]}
