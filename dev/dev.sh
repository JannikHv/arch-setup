#!/bin/sh

pkg_dev=("atom" "electron" "nodejs" "phpmyadmin" "apache" "mariadb" "sassc" "apache" "npm" "gitkraken")

echo -e "[\033[1;34m*\e[0m] Installing dev software"
yaourt -S --noconfirm --needed ${pkg_dev[*]};
