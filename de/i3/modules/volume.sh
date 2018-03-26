#!/bin/sh

output=""

function check_volume() {
    local percent=$(pactl list sinks | grep "Volume:" | sed -n '1p' | awk '{print $5}')
    local muted=$(pactl list sinks | grep "Mute:" | awk '{print $2}')

    if [[ "${percent}" == "0%" || "${muted}" == "yes" ]]; then
        output+="  0%"
    else
        output+="  ${percent}"
    fi
}

check_volume

echo -e "${output}"
