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

cp chroot_commands.sh /mnt/
cp install_yay.sh /mnt/
# chroot into new system
arch-chroot /mnt /chroot_commands.sh &&
echo "Successfully ran the chroot commands!"
rm /mnt/chroot_commands.sh
rm /mnt/install_yay.sh

echo "Please Reboot."
