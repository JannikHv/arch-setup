#!/bin/sh

git clone https://aur.archlinux.org/package-query.git
git clone https://aur.archlinux.org/yaourt.git

cd package-query
yes | makepkg -sir

cd ../yaourt
yes | makepkg -sir

cd ..

rm -rf package-query yaourt
