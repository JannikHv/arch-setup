#!/bin/sh

if [ $EUID -eq 0 ]; then
    echo "You can't be root."
    exit 1
fi

refresh_wp() {
    feh --bg-scale ~/.config/i3/wallpapers/Default
}

clear_wp() {
    rm -rf ~/.config/i3/wallpapers/*
}

assign_wp() {
    clear_wp
    cp -f "${1}" ~/.config/i3/wallpapers/Default
    refresh_wp
}

for arg in $@; do
    case "${1}" in
        -r | --refresh)
            refresh_wp
            shift
            ;;
        *)
            [[ -f ${1} ]] && assign_wp "${1}"
            shift
            ;;
    esac
done
