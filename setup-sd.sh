sd="mmcblk0"
startPath=$(pwd)
username="sindre"

#wget https://downloads.raspberrypi.org/raspbian_lite_latest -O raspbian_lite_latest.zip
#unzip -o raspbian_lite_latest.zip

#dd bs=4M if=2017-11-29-raspbian-stretch-lite.img of=/dev/$sd conv=fsync
mount /dev/$sd"p2" /mnt
mount /dev/$sd"p1" /mnt/boot
cd /mnt

#Generating and adding configs
cp $startPath/configFiles/su etc/pam.d/su -f
cat ~$username/.ssh/id_rsa.pub | tee $startPath/configFiles/authorized_keys
mkdir home/pi/.ssh
cp $startPath/configFiles/authorized_keys home/pi/.ssh/
mkdir home/pi/.config/i3
cp $startPath/configFiles/i3config home/pi/.config/i3/config
mkdir etc/wpa_supplicant
cp $startPath/configFiles/wpa_supplicant.conf etc/wpa_supplicant/
echo "NFC-Client-setup" | tee etc/hostname
echo "dtparam=i2c_arm=on" | tee -a boot/config.txt
echo "dtparam=i2c=on" | tee -a boot/config.txt
echo "dtparam=spi=on" | tee -a boot/config.txt
echo "start_x=1" | tee -a boot/config.txt
touch boot/ssh

#Unmounting
sync
cd $startPath
umount /mnt/boot /mnt
