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
echo "127.0.0.1    localhost" > /etc/hosts
echo "::1          localhost" >> /etc/hosts
echo "127.0.1.1    tyler-pc.localdomain tyler-pc" >> /etc/hosts # replace tyler-pc with your hostname

# make an initramfs
mkinitcpio -P

# set root password
echo "Enter a root password."
passwd

# install bootloader
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
# make grub config
grub-mkconfig -o /boot/grub/grub.cfg
# install microcode
pacman -S amd-ucode # amd only
# pacman -S intel-ucode # intel only

# install dhcpcd ( ethernet service? or wired connection)
pacman -S dhcpcd
systemctl enable dhcpcd # enable dhcpcd

# install sudo
pacman -S sudo vim
useradd -m tyler # replace tyler with your username
usermod -aG wheel tyler # add user to wheel

# set user's password
echo "Enter a password for your main user."
passwd

# change sudoers file
echo "Change the Sudoers file to your needs!"
sleep 4
EDITOR=vim visudo

chown tyler:tyler /home/tyler # makes {username} own the directory
mkdir /home/tyler # change this to your username
cd /home/tyler # change this to your username

# remove vim
pacman -R vim

# install wget
pacman -S wget

# install extra stuff and vim because i like it
pacman -S firefox terminator visual-studio-code-bin vim # my extra stuff you dont need this if you dont want it

# make my directories
mkdir code
mkdir code/godot
mkdir code/asm
mkdir code/repos

# download Godot 3.2.3
wget https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_x11.64.zip
unzip Godot_v3.2.3-stable_x11.64.zip
mv Godot_v3.2.3-stable_x11.64 Godot.64
rm Godot_v3.2.3-stable_x11.64.zip


# install deps needed to build yay and other packages
pacman -S base-devel

# install git
pacman -S git

cd /

eho "Make sure to install yay if you want to at first boot using the script in the root directory!"
sleep 4

echo Done!
sleep 2
