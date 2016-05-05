#!/bin/bash

ISO=~/VBoxGuestAdditions.iso

die() {
    echo "$0: die - $*" >&2
    exit 1
}

press() {
    echo "$*"
    echo "Press <return> to continue [q to quit]"
    read _DUMMY
    [ "$_DUMMY" = "q" ] && exit 0
    [ "$_DUMMY" = "Q" ] && exit 0
}

[ ! -f "$ISO" ] && die "[$PWD] No such iso file <<$ISO>>"

[ ! -d /cdrom ] && sudo mkdir -p /cdrom
[ ! -d /cdrom ] && die "Failed <<sudo mkdir -p /cdrom>>"

echo "Mounting $ISO"
sudo mount -o loop $ISO /cdrom

cd /cdrom/
ls -al /cdrom/

sudo apt install -y gcc make
sudo ./VBoxLinuxAdditions.run --nox11

cd

sudo umount /cdrom

press "About to remove iso file <<$ISO>>"
rm VBoxGuestAdditions.iso 

# rebott should be unnecessary:
# press "About to reboot"
# reboot



