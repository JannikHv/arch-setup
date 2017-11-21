#!/bin/sh

output=""

function check_brightness() {
    # Check if screen is compatible
    xbacklight &> /dev/null || exit 0

    local raw=$(xbacklight)
    local percent=$(echo ${raw} | cut -f1 -d ".")

    output+="  "
    output+="${percent}%"
}

check_brightness

echo -e "${output}"
