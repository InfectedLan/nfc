sudo su
apt update
apt full-upgrade -y
apt install vim tmux git python-numpy python3-dev python-dev python-picamera -y
apt install zbar-tools python-zbar libzbar0 libjpeg8-dev python-requests python-imaging -y
apt install lightdm xserver-xorg xinit xserver-xorg-video-fbdev -y
apt install i3 -y

"en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
"LANG=en_US.UTF-8" > /etc/locale.conf

/etc/lightdm/lightdm.conf
"tmux" >> .bashrc
"exec i3" >> .xserverrc

exit
cd ~
git clone https://github.com/lthiery/SPI-Py
git clone https://github.com/mxgxw/MFRC522-python

cd SPI-Py/
su
python setup.py install

reboot
