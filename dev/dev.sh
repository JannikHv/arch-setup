#!/bin/sh

pkg_dev=("atom" "electron" "nodejs" "phpmyadmin" "php" "php-apache" "php-gd" "apache" "mariadb" "sassc" "apache" "npm" "gitkraken" "docker")

echo -e "[\033[1;34m*\e[0m] Installing dev software"
yaourt -S --noconfirm --needed ${pkg_dev[*]};

echo -e "[\033[1;34m*\e[0m] Configuring files"
sudo cp -f config/httpd.conf         /etc/httpd/conf/httpd.conf
sudo cp -f config/httpd-default.conf /etc/httpd/conf/extra/httpd-default.conf
sudo cp -f config/phpmyadmin.conf    /etc/httpd/conf/extra/phpmyadmin.conf
sudo cp -f config/php.ini            /etc/php/php.ini
