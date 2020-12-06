# arch-installer

# About
This is an arch install for my needs you can fork it if you want.

# Installing

To Install type this in the Arch Installer:
```
pacman -Sy git && git clone https://github.com/Cat-Gaming/arch-installer.git && cd arch-installer && chmod +x *.sh && ./arch-installer.sh
```

# Partitions

| Disk:     	| Type:               	| Size:                                       	|
|-----------	|---------------------	|---------------------------------------------	|
| /dev/sda1 	| EFI System          	| 512M                                        	|
| /dev/sda2 	| Linux root (x86_64) 	| Remainder of Disk                           	|
| /dev/sda3 	| Linux swap          	| Half of RAM size example: 8G Ram == 4G Swap 	|
