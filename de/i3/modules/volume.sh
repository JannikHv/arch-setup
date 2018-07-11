#!/bin/sh

output=""

function check_volume() {
    pgrep pulseaudio &> /dev/null || exit 0

    local percent=$(pacmd list-sinks | grep volume | sed -n '1p' | awk '{print $5}')
    local muted=$(pacmd list-sinks | grep "muted: yes")

    if [[ -n $muted ]]; then
        output+="  ${percent}"
    elif [[ "${percent}" == "0%" ]]; then
        output+="    ${percent}"
    else
        output+="  ${percent}"
    fi
}

check_volume

echo -e "${output}"
