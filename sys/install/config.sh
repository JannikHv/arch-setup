#!/bin/sh

alias echo="echo -e"

function conf_time() {
    echo "[\033[1;34m*\e[0m] Configuring Time"
    rm /etc/localtime
    ln -s "/usr/share/zoneinfo/${arg_zone}" /etc/localtime
    hwclock --systohc --utc &> /dev/null
    systemctl enable systemd-timesyncd NetworkManager
}

function conf_lang() {
    echo "[\033[1;34m*\e[0m] Configuring Language"
    echo ""                  >> /etc/locale.gen
    echo "de_DE.UTF-8 UTF-8" >> /etc/locale.gen
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen &> /dev/null
    export LANG=en_US.UTF-8
    echo "LANG=en_US.UTF-8"    > /etc/locale.conf
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment
    echo "LANG=en_US.UTF-8"   >> /etc/environment

    localectl set-keymap de
}

function conf_repo() {
    echo "[\033[1;34m*\e[0m] Configuring Repository"
    echo ""                                        >> /etc/pacman.conf
    echo "[multilib]"                              >> /etc/pacman.conf
    echo "Include = /etc/pacman.d/mirrorlist"      >> /etc/pacman.conf
    echo ""                                        >> /etc/pacman.conf
    echo "[archlinuxfr]"                           >> /etc/pacman.conf
    echo "SigLevel = Never"                        >> /etc/pacman.conf
    echo 'Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
    pacman -Syyu --noconfirm &> /dev/null
}

function conf_pkg() {
    echo "[\033[1;34m*\e[0m] Configuring Packages"
    pacman -R --noconfirm linux &> /dev/null
    pacman -S --noconfirm grub  &> /dev/null
}

function conf_user() {
    echo "[\033[1;34m*\e[0m] Configuring User Accounts"
    useradd -m -g users -G wheel,storage,power -s /bin/bash "${arg_user}"
    chfn -f "${arg_name}" "${arg_user}" &> /dev/null
    loadkeys -q -d de

    chpasswd <<< "root:${arg_pass}"
    chpasswd <<< "${arg_user}:${arg_pass}"

    sed -i -e 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers

    echo "${arg_host}" > /etc/hostname
}

function conf_boot() {
    echo "[\033[1;34m*\e[0m] Configuring Bootloader"
    mkinitcpio -p linux-lts &> /dev/null
    grub-install --target=i386-pc ${arg_disk} &> /dev/null

    # Tweak /etc/default/grub for smooth boot
    sed -i -e 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g'                                  /etc/default/grub
    sed -i -e 's/#GRUB_HIDDEN_TIMEOUT=5/GRUB_HIDDEN_TIMEOUT=0/g'                   /etc/default/grub
    sed -i -e 's/#GRUB_HIDDEN_TIMEOUT_QUIET=true/GRUB_HIDDEN_TIMEOUT_QUIET=true/g' /etc/default/grub

    sed -i -e 's/#HandlePowerKey=poweroff/HandlePowerKey=ignore/g'             /etc/systemd/logind.conf
    sed -i -e 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/g'            /etc/systemd/logind.conf
    sed -i -e 's/#HandleLidSwitchDocked=ignore/HandleLidSwitchDocked=ignore/g' /etc/systemd/logind.conf

    grub-mkconfig -o /boot/grub/grub.cfg &> /dev/null

    # Disable pcspkr module
    echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
}

# Evaluating arguments
for i in $@; do
    case $1 in
        -d | --disk)
            arg_disk="${2}"
            shift
            ;;
        -p | --password)
            arg_pass="${2}"
            shift
            ;;
        -h | --hostname)
            arg_host="${2}"
            shift
            ;;
        -u | --username)
            arg_user="${2}"
            shift
            ;;
        -f | --fullname)
            arg_name="${2}"
            shift
            ;;
        -z | --zone)
            arg_zone="${2}"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

if [[ -e "${arg_disk}" ]]; then
    conf_time
    conf_lang
    conf_repo
    conf_pkg
    conf_user
    conf_boot
    echo "Don't forget to install video drivers."
    exit 0
else
    echo "[\033[1;31m-\e[0m] Disk not found: ${1}"
    exit 1
fi
