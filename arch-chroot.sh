#!/bin/sh

# Load ${arg_disk}, ${arg_password}
source <(curl -s https://raw.githubusercontent.com/JannikHv/arch-setup/refactor/args.sh)

rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
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

echo ""                                   >> /etc/pacman.conf
echo "[multilib]"                         >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

pacman -Syyu grub git wget

useradd -m -g users -G wheel,storage,power -s /bin/bash jannik
chfn -f "Jannik Hauptvogel" jannik
loadkeys -q -d de
chpasswd <<< "root:${arg_password}"
chpasswd <<< "jannik:${arg_password}"

# TODO: Fix
sed -i -e 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers
echo "ArchPad" > /etc/hostname

mkinitcpio -p linux
grub-install --target=i386-pc ${arg_disk}

sed -i -e 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g'                              /etc/default/grub
sed -i -e 's/#HandlePowerKey=poweroff/HandlePowerKey=ignore/g'             /etc/systemd/logind.conf
sed -i -e 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/g'            /etc/systemd/logind.conf
sed -i -e 's/#HandleLidSwitchDocked=ignore/HandleLidSwitchDocked=ignore/g' /etc/systemd/logind.conf

grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --noconfirm xf86-video-intel

rm -f /mnt/root/arch-chroot.sh

wget https://raw.githubusercontent.com/JannikHv/arch-setup/refactor/post-install.sh -o /mnt/home/jannik/post-install.sh
chmod +x /mnt/home/jannik/post-install.sh