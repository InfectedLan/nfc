ssh alarm@NFC-Client-setup
su
pacman -Syu --noconfirm
pacman -S vim tmux python python-numpy opencv zbar hdf5 pip git --noconfirm
pip install zbar-py
"en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
"LANG=en_US.UTF-8" > /etc/locale.conf
reboot
