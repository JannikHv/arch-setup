#/bin/sh

### Install yay
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd ~/ && xdg-user-dirs-update