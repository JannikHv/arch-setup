#!/bin/sh

$disk='/dev/sda'
password_root='' # TODO: Add password
password_user='' # TODO: Add password

### Load keymap
# localectl list-keymaps
loadkeys de

### Use best mirrors
pacman -Sy reflector
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

### Clear disk
wipefs -a -f ${disk}
partprobe
sync

### Create disk partitions
fdisk /dev/sda
# Boot partition: n, p, /, /, +2G
# Root partition: n, p, /, /, /
# Add boot flag: a, 1
# Write and exit: w

### Mount disk partitions
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

### Base install
pacstrap /mnt base base-devel linux linux-headers git python3 bash-completion networkmanager

### Generate fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

### TODO
arch-chroot /mnt

###
rm -f /etc/localtime
ln -s "/usr/share/zoneinfo/Europe/Berlin" /etc/localtime
hwclock --systohc --utc
systemctl enable systemd-timesyncd NetworkManager

echo ""                  >> /etc/locale.gen
echo "de_DE.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
export LANG=en_US.UTF-8
echo "LANG=en_US.UTF-8"    > /etc/locale.conf
echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "LANG=en_US.UTF-8"   >> /etc/environment
echo "KEYMAP=de" > /etc/vconsole.conf
# localectl set-keymap de # Error?

###
echo ""                                        >> /etc/pacman.conf
echo "[multilib]"                              >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist"      >> /etc/pacman.conf

pacman -Syyu grub

useradd -m -g users -G wheel,storage,power -s /bin/bash jannik
chfn -f "Jannik Hauptvogel" jannik
loadkeys -q -d de
chpasswd <<< "root:${password_root}"
chpasswd <<< "jannik:${password_user}"
sed -i -e 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers
echo "ArchPad" > /etc/hostname

###
mkinitcpio -p linux
grub-install --target=i386-pc ${disk}

sed -i -e 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g'                              /etc/default/grub
sed -i -e 's/#HandlePowerKey=poweroff/HandlePowerKey=ignore/g'             /etc/systemd/logind.conf
sed -i -e 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/g'            /etc/systemd/logind.conf
sed -i -e 's/#HandleLidSwitchDocked=ignore/HandleLidSwitchDocked=ignore/g' /etc/systemd/logind.conf

grub-mkconfig -o /boot/grub/grub.cfg

pacman -S xf86-video-intel
