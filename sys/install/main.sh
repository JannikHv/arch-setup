#!/bin/sh

setterm --powersave off
setterm --blank 0

function show_usage() {
    echo "Arguments:"
    echo "  -d | --disk"
    echo "  -p | --password"
    echo "  -h | --hostname"
    echo "  -u | --username"
    echo "  -f | --fullname"
    echo "  -z | --zone"
}

function disk_unmount() {
    umount -R /mnt
}

# Evaluating arguments
for i in $@; do
    case $1 in
        -d | --disk)     arg_disk="${2}"
                         shift
                         ;;
        -p | --password) arg_pass="${2}"
                         shift
                         ;;
        -h | --hostname) arg_host="${2}"
                         shift
                         ;;
        -u | --username) arg_user="${2}"
                         shift
                         ;;
        -f | --fullname) arg_name="${2}"
                         shift
                         ;;
        -z | --zone)     arg_zone="${2}"
                         shift
                         ;;
                      *) shift
                         ;;
    esac
done

# Show usage and quit if any argument is not set
if [[ -z "${arg_disk}" ||
      -z "${arg_pass}" ||
      -z "${arg_host}" ||
      -z "${arg_user}" ||
      -z "${arg_name}" ||
      -z "${arg_zone}" ]]; then
    show_usage
    exit 1
fi

curl https://raw.githubusercontent.com/JannikHv/arch-setup/master/sys/install/disk.sh > disk.sh
sh disk.sh "${arg_disk}"

curl https://raw.githubusercontent.com/JannikHv/arch-setup/master/sys/install/config.sh > /mnt/root/config.sh
chmod +x /mnt/root/config.sh

arch-chroot /mnt /root/config.sh -d "${arg_disk}" \
                                 -p "${arg_pass}" \
                                 -h "${arg_host}" \
                                 -u "${arg_user}" \
                                 -f "${arg_name}" \
                                 -z "${arg_zone}"

rm /mnt/root/config.sh
rm disk.sh

disk_unmount
