#!/bin/sh

output=""

function check_network() {
    local device=$(ip route get 8.8.8.8 | sed -n '1p' | awk '{print $5}')
    local ipaddr=$(ip route get 8.8.8.8 | sed -n '1p' | awk '{print $7}')

    # Check if offline
    if [[ ! -d "/sys/class/net/${device}" || -z ${device} ]]; then
        output+=""
        return
    fi

    # Check if connection is wired or wireless
    if [[ -d "/sys/class/net/${device}/wireless" ]]; then
        output+=" "
    else
        output+=" "
    fi

    output+="${ipaddr}"
}

check_network

echo -e "${output}"
