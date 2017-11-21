#!/bin/sh

output=""

function check_battery() {
    # Check if battery present
    [[ "$(ls /sys/class/power_supply)" ]] || exit 0

    local status=$(acpi | awk '{print $3}')
    local percent=$(acpi | awk '{print $4}' | sed 's|[^0-9]||g')

    # Check if device is docked
    [[ "${status}" == *"Charging"* || "${status}" == *"Unknown"* ]] && output+=" "

    if [[ ${percent} -lt 10 ]]; then
        output+=" "
    elif [[ ${percent} -lt 25 ]]; then
        output+=" "
    elif [[ ${percent} -lt 50 ]]; then
        output+=" "
    elif [[ ${percent} -lt 75 ]]; then
        output+=" "
    else
        output+=" "
    fi

    output+="${percent}%"
}

check_battery

echo -e "${output}"
