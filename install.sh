ssh alarm@NFC-Client-setup
su
pacman -Syu --noconfirm
pacman -S vim tmux --noconfirm
"en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
"LANG=en_US.UTF-8" > /etc/locale.conf
reboot
