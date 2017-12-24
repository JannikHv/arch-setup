#!/bin/sh

output=""

function check_time() {
    local format="+%H:%M:%S"

    output+="  $(date "${format}")"
}

check_time

echo -e "${output}"
