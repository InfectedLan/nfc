exec pacman -Syu --noconfirm
exec pacman -S vim tmux --noconfirm
"en_US.UTF-8 UTF-8" > /etc/locale.gen
exec locale-gen
"LANG=en_US.UTF-8" > /etc/locale.conf
exec reboot
