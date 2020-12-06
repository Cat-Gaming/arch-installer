#!/bin/bash

if [[ $(ls /sys/firmware/efi/efivars) ]]; then
    echo "Booted in UEFI Mode."
else
    echo "Error Not Booted in UEFI Mode Please boot in UEFI Mode!"
    read -p "Error" input
fi

if [[ $( ping -c 2 archlinux.org ) ]]; then
    echo "Connected to the internet!"
else
    echo "Not connected to the internet!"
fi
