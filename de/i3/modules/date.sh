#!/bin/sh

output=""

function check_date() {
    output+="  $(date "+%a %d.%m.%Y")"
}

check_date

echo -e "${output}"
