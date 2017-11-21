#!/bin/sh

output=""

function check_user() {
    local username=$(getent passwd "${USER}" | cut -d ':' -f5 | cut -d ',' -f1)

    output+="  ${username}"
}

check_user

echo -e "${output}"
