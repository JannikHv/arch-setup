#!/bin/sh

output=""

function check_mount() {
    local found=false

    for i in $(ls /dev/sd* | sed '/sda/d'); do
        if mount | grep -q "${i}"; then
            output+=" "
            return
        else
            found=true
        fi
    done

    $found && output+=" " || exit 0
}

check_mount

echo -e "${output}"
