#!/bin/bash

# check if booted in EFI
if [[ $(ls /sys/firmware/efi/efivars) ]]; then
    echo "Booted in UEFI Mode."
else
    echo "Error Not Booted in UEFI Mode Please boot in UEFI Mode!"
    read -p "Error" input
fi

# check if connected to the internet
if [[ $( ping -c 2 archlinux.org ) ]]; then
    echo "Connected to the internet!"
else
    echo "Not connected to the internet!"
fi

# ensure system clock is accurate
timedatectl set-ntp true

# be careful with this script
mkfs /dev/sda # erases drive
cfdisk /dev/sda # allows user to partition drives
# How the Partition should be layed out
# EFI 512MiB
# Root remainder of drive
# Swap partition 8G

# format partitions
mkfs.fat -F 32 /dev/sda1
mkfs.ext4 /dev/sda2
mkswap /dev/sda3

# mount partitions
mount /dev/sda2 /mnt
mkdir /mnt/boot # makes boot mountpoint
mount /dev/sda1 /mnt/boot # mounts efi partition to /mnt/boot
swapon /dev/sda3

# install base arch
pacstrap /mnt base linux linux-firmware
# generate an fstab
genfstab -U /mnt >> /mnt/etc/fstab
# chroot into new system
arch-chroot /mnt

# set timezone
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

hwclock --systohc

# set locale to generate
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
# locales to gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

# network configuration
echo tyler-pc > /etc/hostname # just my personal preferance
# more network configuration
echo "127.0.0.1    localhost" > hosts
echo "::1          localhost" >> hosts
echo "127.0.1.1    tyler-pc.localdomain tyler-pc" >> hosts # replace tyler-pc with your hostname

# make an initramfs
mkinitcpio -P

# set root password
echo "Enter a root password."
passwd

# install bootloader
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

# install sudo
pacman -S sudo
useradd -m tyler # replace tyler with your username
usermod -aG wheel tyler # add user to wheel
echo "Allow the group Wheel in by uncommenting the line that says: "

# install extra stuff

