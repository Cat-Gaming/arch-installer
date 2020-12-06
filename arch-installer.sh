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
