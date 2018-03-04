#!/bin/sh

if [[ ${EUID} -eq 0 ]]; then
    echo "You can't be Root."
    exit 1
fi

cp -f "config/xinitrc" "${HOME}/.xinitrc"
