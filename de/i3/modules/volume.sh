#!/bin/sh

output=""

function check_volume() {
    local percent=$(pactl list sinks | grep "Volume:" | sed -n '1p' | awk '{print $5}')
    local number=${percent::-1}

    # Check if muted
    if pactl list sinks | grep "Mute: yes" &> /dev/null; then
        output+=" 0%"
        return
    fi

    if [[ ${number} -eq 0 ]]; then
        output+=" "
    elif [[ ${number} -lt 50 ]]; then
        output+=" "
    else
        output+=" "
    fi

    output+=" ${percent}"
}

check_volume

echo -e "${output}"
