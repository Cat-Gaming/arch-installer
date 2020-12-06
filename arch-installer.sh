#!/bin/bash

if [[ $(ls /sys/firmware/efi/efivars) ]]; then
    echo "Booted in UEFI Mode."
else
    echo "Error Not Booted in UEFI Mode"
    read -p "Error" input
fi
