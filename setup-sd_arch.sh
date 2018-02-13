sdp1="mmcblk0p1"
sdp2="mmcblk0p2"
startPath=$(pwd)
if [ ! -d "/mnt/arm" ]; then
    mkdir /mnt/arm
fi
cd /mnt/arm
if [ ! -d "root" ]; then
    mkdir root
fi
if [ ! -d "boot" ]; then
    mkdir boot
fi

#Formatting and mounting boot
mkfs.vfat /dev/$sdp1
mount /dev/$sdp1 boot
#Formatting and mounting root
mkfs.ext4 /dev/$sdp2 -F
mount /dev/$sdp2 root

#Downloading and installing arch
wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-3-latest.tar.gz -O ArchLinuxARM-rpi-3-latest.tar.gz
bsdtar -xpf ArchLinuxARM-rpi-3-latest.tar.gz -C root
sync
mv root/boot/* boot
sync

#Generating and adding configs
cp $startPath/configFiles/su root/etc/pam.d/su -f
cat ~/.ssh/id_rsa.pub > $startPath/configFiles/authorized_keys
mkdir root/home/alarm/.ssh
cp $startPath/configFiles/authorized_keys root/home/alarm/.ssh/
echo "NFC-Client-setup" | sudo tee root/etc/hostname

#Unmounting
umount boot root
