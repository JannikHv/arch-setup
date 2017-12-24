#!/bin/sh

output=""

function check_date() {
    local format="+%a %d.%m.%Y"

    output+="  $(date "${format}") "
}

check_date

echo -e "${output}"
