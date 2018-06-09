#!/bin/sh

output=""

function check_dropbox() {
    # Check if dropbox is actually running
    pgrep dropbox &> /dev/null || exit 0

    local status=$(dropbox-cli status | sed -n '1p' | awk '{print $1}')
    local updown=$(dropbox-cli status | sed -n '2p' | awk '{print $1}')

    if [[ "${status}" == "Up" ]]; then
        output+=" "
    elif [[ "${status}" == *"Syncing"* ]]; then
        if [[ "${updown}" == "Indexing" || "${updown}" == "Uploading" ]]; then
            output+=" "
        elif [[ "${updown}" == "Downloading" ]]; then
            output+=" "
        else
            output+=" "
        fi
    else
        exit 0
    fi
}

check_dropbox

echo -e "${output}"
