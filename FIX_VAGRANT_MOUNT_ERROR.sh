
# TODO: treat arguments ... cleanup ... check for vboxsf else prompt for VBoxGuestAdditions iso.

  #sudo mount -t vboxsf -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` vagrant /vagrant
  #sudo mount.vboxsf -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` vagrant /vagrant

USER=vagrant
USER=ubuntu

sudo mount.vboxsf -o uid=`id -u $USER`,gid=`getent group $USER | cut -d: -f3` vagrant /vagrant

