#!/bin/sh

for i in $@; do
    case "${1}" in
        -in)
            in="${2}";
            shift 2;
            ;;
        -out)
            out="${2}";
            shift 2;
            ;;
        *)
            shift;
            ;;
    esac
done

if [[ -z "${in}" || -z "${out}" ]]; then
    exit 1
fi

while inotifywait -e modify "${in}"; do
    sassc --style compressed "${in}" > "${out}"
done
