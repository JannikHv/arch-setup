#!/bin/sh

# Load ${arg_disk}, ${arg_password}
source <(curl -s https://raw.githubusercontent.com/JannikHv/arch-setup/refactor/args.sh)

### Load keymap
# localectl list-keymaps
loadkeys de

### Use best mirrors
pacman -Sy reflector
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

### Clear disk
wipefs -a -f ${arg_disk}
partprobe
sync

### Create disk partitions
read -p "Press enter to create partitions with "

# Boot partition: n, p, /, /, +2G
fdisk_cmd="n\n p\n \n \n +2G\n " # Create boot partition

# Root partition: n, p, /, /, /
fdisk_cmd+="n\n p\n \n \n \n " # Create root partition

# Add boot flag: a, 1
fdisk_cmd+="a\n 1\n " # Add boot flag to boot partition

# Write and exit: w
fdisk_cmd+="w\n" # Write and exit

printf "${fdisk_cmd}" | fdisk -w always -W always ${arg_disk}
sync

### Mount disk partitions
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

### Base install
pacstrap /mnt base base-devel linux linux-headers linux-firmware git python3 bash-completion networkmanager

### Generate fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

### TODO
wget https://raw.githubusercontent.com/JannikHv/arch-setup/refactor/arch-chroot.sh -o /mnt/root/arch-chroot.sh
chmod +x /mnt/root/arch-chroot.sh
arch-chroot /mnt /mnt/root/arch-chroot.sh -d "${arg_disk}" -p "${arg_password}"
