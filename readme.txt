Ment to be used with raspberry pi and as a single user application. By running the scripts you sett up the pi to auto start this application.

SDcard installation: https://archlinuxarm.org/platforms/armv6/raspberry-pi
if you are using the rpi 3 you have to change the image path, see the settup-sd.sh for info.
fdisk /dev/"your sdcard"
    a. Type o. This will clear out any partitions on the drive.
    b. Type p to list partitions. There should be no partitions left.
    c. Type n, then p for primary, 1 for the first partition on the drive, press ENTER to accept the default first sector, then type +100M for the last sector.
    d. Type t, then c to set the first partition to type W95 FAT32 (LBA).
    e. Type n, then p for primary, 2 for the second partition on the drive, and then press ENTER twice to accept the default first and last sector.
    f. Write the partition table and exit by typing w.

You have to edit the settup-sd.sh script to include your sdpartitions, variables at the top.
Run the sd settup script
sudo ./settup-sd.sh


Pinnout:
sda   24
sck   23
mosi  19
miso  21
gnd   20
rst   22
3.3v  17


Requierments:
https://github.com/mxgxw/MFRC522-python
https://github.com/lthiery/SPI-Py

Clone this repo
Run setup.sh

Enable SPI
