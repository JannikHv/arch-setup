#!/bin/sh

show_usage() {
    echo "Arguments:"
    echo "  -d | --disk"
    echo "  -p | --password"
}

disk_unmount() {
    umount -R /mnt
}

# Evaluating arguments
for i in ${@}; do
    case ${1} in
        -d | --disk)
            export arg_disk="${2}"
            shift
            ;;
        -p | --password)
            export arg_password="${2}"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Show usage and quit if any argument is not set
if [[ -z "${arg_disk}" || -z "${arg_password}" ]]; then
    show_usage
    exit 1
fi