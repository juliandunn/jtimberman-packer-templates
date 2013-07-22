if [ -f /home/vagrant/.vbox_version ]; then

    # Without libdbus virtualbox would not start automatically after compile
    apt-get -y install --no-install-recommends libdbus-1-3

    # The netboot installs the VirtualBox support (old) so we have to remove it
    /etc/init.d/virtualbox-ose-guest-utils stop
    rmmod vboxguest
    aptitude -y purge virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms virtualbox-ose-guest-utils
    aptitude -y install dkms

    # Install the VirtualBox guest additions
    VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
    VBOX_ISO=VBoxGuestAdditions_$VBOX_VERSION.iso
    mount -o loop $VBOX_ISO /mnt
    yes|sh /mnt/VBoxLinuxAdditions.run
    umount /mnt

    #Cleanup VirtualBox
    rm $VBOX_ISO
fi

if [ -f /home/vagrant/vmware_tools.iso ]; then
echo "Installing VMWare Tools"
    #Set Linux-specific paths and ISO filename
    home_dir="/home/vagrant"
    iso_name="vmware_tools.iso"
    mount_point="/tmp/vmware-tools"
    #Run install, unmount ISO and remove it
    mkdir ${mount_point}
    cd ${home_dir}
    /bin/mount -o loop ${iso_name} ${mount_point}
    tar zxf ${mount_point}/*.tar.gz && cd vmware-tools-distrib && ./vmware-install.pl --default
    /bin/umount ${mount_point}
    /bin/rm -rf ${home_dir}/${iso_name} ${home_dir}/vmware-tools-distrib
    rmdir ${mount_point}
fi
