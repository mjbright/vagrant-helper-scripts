#!/bin/bash

#
# This script will serve up the VirtualBox installation directory 
# to facilitate downloading the VBoxGuestAdditions iso to a
# running VM (don't need to determine version number to do download from virtualbox.com)
#
# Run the script with no arguments (configure VBOX_DIR first)
# and you will be instructed with the wget command to download the iso from
# the (local)host machine
#

PORT=8000
#VBOX_DIR='/cygdrive/c/Program\ Files/Oracle/VirtualBox/'
VBOX_DIR='/cygdrive/c/Program Files/Oracle/VirtualBox/'


die() {
    echo "$0: die - $*" >&2
    exit 1
}

[ ! -x "/cygdrive/c/windows/system32/ipconfig" ] && die "Currently Windows only ..."

MYIP=$(ipconfig | awk '(/ 192.168.0./ || / 10.3/ || / 16./) && /IPv4/ { print $NF ;}')

[ ! -d "$VBOX_DIR" ] && die "No such dir as <<'$VBOX_DIR'>>"

ISO=$(find "$VBOX_DIR" -iname '*guestaddition*.iso' | tail -1)
[ ! -f "$ISO" ] && die "No such iso as <<'$ISO'>>"

ISO_FILE=${ISO##*/}

echo
echo "Found VirtualBox guest additions iso <$ISO>"
echo

cd "$VBOX_DIR"

[ ! -f "$ISO_FILE" ] && die "No such iso file as <<$ISO_FILE>> in dir <<$VBOX_DIR>>"
pwd
ls -altr "$ISO_FILE"

echo "Serving up on $HOST:$PORT"
echo "Download with command:"
echo "    wget http://$MYIP:$PORT/$ISO_FILE"
echo

# python3:
BIND="--bind $MYIP"
CMD="python -m http.server $PORT $BIND"
echo $CMD
$CMD
#python -m http.server $PORT $BIND

# python2:
#python -m SimpleHTTPServer $PORT

exit 0

