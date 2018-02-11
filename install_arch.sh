ssh alarm@NFC-Client-setup
su
pacman -Syu --noconfirm
pacman -S vim tmux python python-numpy opencv zbar hdf5 python-pip git wget --noconfirm
pip install zbar-py

"en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
"LANG=en_US.UTF-8" > /etc/locale.conf
reboot

ssh alarm@NFC-Client-setup
git clone https://github.com/lthiery/SPI-Py
git clone https://github.com/mxgxw/MFRC522-python
git clone https://aur.archlinux.org/python-raspberry-gpio.git
cd python-raspberry-gpio
makepkg -Acs
su
pacman -U python-raspberry-gpio-0.6.3-1-aarch64.pkg.tar.xz

cd SPI-Py/
python setup.py install

