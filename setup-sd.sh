sd="mmcblk0"
startPath=$(pwd)

wget https://downloads.raspberrypi.org/raspbian_lite_latest -O raspbian_lite_latest.zip
unzip -o raspbian_lite_latest.zip

dd bs=4M if=2017-11-29-raspbian-stretch-lite.img of=/dev/mmcblk0 conv=fsync
mount /dev/$sd"p2" /mnt
mount /dev/$sd"p1" /mnt/boot
cd /mnt

#Generating and adding configs
cp $startPath/configFiles/su etc/pam.d/su -f
cat ~/.ssh/id_rsa.pub > $startPath/configFiles/authorized_keys
mkdir home/pi/.ssh
cp $startPath/configFiles/authorized_keys home/pi/.ssh/
echo "NFC-Client-setup" | tee etc/hostname
echo "dtparam=i2c_arm=on" | tee -a boot/config.txt
echo "dtparam=i2c=on" | tee -a boot/config.txt
echo "dtparam=spi=on" | tee -a boot/config.txt
touch boot/ssh

#Unmounting
sync
cd $startPath
umount /mnt/boot /mnt
