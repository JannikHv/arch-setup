#!/bin/sh

if [[ $EUID -ne 0 ]]; then
        root_flag="sudo"
fi

${root_flag} pacman -R $(pacman -Qdtq) --noconfirm

while [ $? -eq 0 ]; do
    ${root_flag} pacman -R $(pacman -Qdtq) --noconfirm
done
