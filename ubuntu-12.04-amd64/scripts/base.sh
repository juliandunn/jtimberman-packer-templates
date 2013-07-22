apt-get -y update
apt-get -y upgrade
apt-get -y install build-essential curl wget git linux-headers-$(uname -r)
apt-get -y install vim emacs emacs-goodies-el
apt-get clean

# Set up sudo
( cat <<'EOP'
%vagrant ALL=NOPASSWD:ALL
EOP
) > /tmp/vagrant
chmod 0440 /tmp/vagrant
mv /tmp/vagrant /etc/sudoers.d/
