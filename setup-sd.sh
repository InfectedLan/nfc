$sdp1 = mmcblk0p1
$sdp2 = mmcblk0p2
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
mkfs.vfat /dev/$sdp2
mount /dev/$sdp2 root
wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpii-3-latest.tar.gz
bsdtar -xpf ArchLinuxARM-rpi-3-latest.tar.gz -C root
sync
mv root/boot/* boot
sync
umount boot root
