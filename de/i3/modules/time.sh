#!/bin/sh

output=""

function check_time() {
    output+="  $(date "+%H:%M:%S")"
}

check_time

echo -e "${output}"
