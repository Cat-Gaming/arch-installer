#/bin/bash

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


