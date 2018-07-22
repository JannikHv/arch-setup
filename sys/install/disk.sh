#!/bin/sh

alias echo="echo -e"

function clear_disk() {
    local disk=${1}

    echo "[\033[1;34m*\e[0m] Clearing Disk"
    wipefs -a -f ${disk} &> /dev/null
    printf "o\n w\n" | fdisk -w always -W always ${disk} &> /dev/null || \
        { printf "\033[1;31m-\e[0m] Failed to clear disk."; read; }

    partprobe &> /dev/null

    sync

    echo ""
}

function create_partitions() {
    local cmd
    local disk=${1}
    local part_boot="${disk}1"
    local part_swap="${disk}2"
    local part_root="${disk}3"
    local part_home="${disk}4"

    local size_boot=1
    local size_swap=$(expr $(cat /proc/meminfo | sed -n 1p | awk '{print $2}') / 1048576 + 1)
    local size_root=50

    echo "[\033[1;34m*\e[0m] Creating Partition"

    cmd="n\n p\n \n \n +${size_boot}G\n "
    cmd+="n\n p\n \n \n +${size_swap}G\n "
    cmd+="n\n p\n \n \n +${size_root}G\n "
    cmd+="n\n p\n \n \n \n "
    cmd+="a\n 1\n w\n"

    printf "$cmd" | fdisk -w always -W always ${disk} &> /dev/null; sync

    # Create filesystems
    echo "[\033[1;34m*\e[0m] Creating Filesystems"
    mkfs.ext2 -F ${part_boot} &> /dev/null && \
        echo "[\033[1;32m+\e[0m] Filesystem created: ${part_boot}" || \
        { printf "[\033[1;31m-\e[0m] Partition not found: ${part_boot}"; read; }

    mkswap -f ${part_swap} &> /dev/null && \
        echo "[\033[1;32m+\e[0m] Filesystem created: ${part_swap}" || \
        { printf "[\033[1;31m-\e[0m] Partition not found: ${part_swap}"; read; }

    mkfs.ext4 -F ${part_root} &> /dev/null && \
        echo "[\033[1;32m+\e[0m] Filesystem created: ${part_root}" || \
        { printf "[\033[1;31m-\e[0m] Partition not found: ${part_root}"; read; }

    mkfs.ext4 -F ${part_home} &> /dev/null && \
        echo "[\033[1;32m+\e[0m] Filesystem created: ${part_home}" || \
        { printf "[\033[1;31m-\e[0m] Partition not found: ${part_home}"; read; }

    echo ""
}

function mount_partitions() {
    local disk=${1}
    local part_boot="${disk}1"
    local part_swap="${disk}2"
    local part_root="${disk}3"
    local part_home="${disk}4"

    echo "[\033[1;34m*\e[0m] Mounting Partitions"
    mount ${part_root} /mnt && \
        echo "[\033[1;32m+\e[0m] Mounted ${part_root}: /mnt" || \
        { printf "[\033[1;31m-\e[0m] Failed to mount ${part_root}: /mnt"; read; }

    mkdir /mnt/{home,boot}

    mount ${part_boot} /mnt/boot && \
        echo "[\033[1;32m+\e[0m] Mounted ${part_boot}: /mnt/boot" || \
        { printf "[\033[1;31m-\e[0m] Failed to mount ${part_boot}: /mnt/boot"; read; }

    mount ${part_home} /mnt/home && \
        echo "[\033[1;32m+\e[0m] Mounted ${part_home}: /mnt/home" || \
        { printf "[\033[1;31m-\e[0m] Failed to mount ${part_home}: /mnt/home"; read; }

    swapon ${part_swap} && \
        echo "[\033[1;32m+\e[0m] Activated ${part_swap}" || \
        { printf "[\033[1;31m-\e[0m] Failed to activate ${part_swap}"; read; }

    echo ""
}

function base_install() {
    echo "[\033[1;34m*\e[0m] Installing Base"
    pacstrap /mnt base base-devel linux-lts linux-lts-headers git python3 bash-completion networkmanager &> /dev/null && \
        echo "[\033[1;32m+\e[0m] Installed base system" || \
        { printf "[\033[1;31m-\e[0m] Failed to install base system"; read; }

    genfstab -U -p /mnt >> /mnt/etc/fstab && \
        echo "[\033[1;32m+\e[0m] Generated fstab" || \
        { printf "[\033[1;31m-\e[0m] Failed to generate fstab"; read; }

    echo ""
}

if [[ -e ${1} ]]; then
    clear_disk ${1}
    create_partitions ${1}
    mount_partitions ${1}
    base_install
    exit 0
else
    echo "[\033[1;31m-\e[0m] Disk not found: ${1}"
    exit 1
fi
