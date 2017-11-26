#!/bin/sh

output=""

function check_datetime() {
    local format="+%d.%m.%Y %H:%M:%S"

    output+="  $(date "${format}")"
}

check_datetime

echo -e "${output}"
