#!/bin/bash
# Install Intructions
# sudo (apt/yum/zypper) install -y curl
# sudo curl -s https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/AcuScripts/setup.sh | bash 

user=support
echo "$user:Unidos30" | chpasswd

if command -v yum >/dev/null; then
  sudo yum update -y;
  sudo dnf group install -y "Development Tools";
  sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm;
  sudo dnf install -y libnsl podman unixODBC wget curl cronie dos2unix java-11-openjdk htop tmux libstdc++.i686 libxcrypt.i686 ncurses-libs-6.1-9.20180224.el8.i686 libaio-devel glibc.i686 zlib-1.2.11-18.el8_5.i686 tcpdump ed glibc-devel.i686 spax;
  sudo setenforce 0;
  sudo sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config;
elif command -v apt >/dev/null; then
  . /etc/os-release
  sudo apt update;
  sudo apt upgrade -y;
  sudo dpkg --add-architecture i386;
  sudo apt install -y build-essential podman unixodbc-dev wget curl cron dos2unix default-jdk htop tmux lib32stdc++6 libaio-dev libncurses5 apt-file zlib1g:i386 tcpdump libgc1 pax;
  sudo apt-file update;
elif command -v zypper >/dev/null; then
  sudo zypper refresh;
  sudo zypper update -y;
  sudo zypper install -y -t pattern devel_C_C++;
  sudo zypper install -y cronie podman unixODBC wget curl dos2unix glibc-32bit java-11-openjdk htop tmux libcrypt1-32bit libncurses5-32bit libaio-devel libstdc++6-32bit libgcc_s1-32bit libz1-32bit tcpdump ed spax;
else
  echo "Install CMD not identified"
fi

echo "if [[ -t 0 && $- = *i* ]]; then stty -ixon; fi" >> /home/$user/.bashrc
sudo sed -i -E 's/#?AllowTcpForwarding no/AllowTcpForwarding yes/' /etc/ssh/sshd_config
sudo sed -i -E 's/#?PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo service ssh restart &>/dev/null
sudo service sshd restart &>/dev/null  

cd /home
[ ! -d "products" ] && sudo mkdir -m 755 products
sudo chown -R $user:$user products

cd /home/$user
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/AcuScripts/profile.sh
sudo mv profile.sh /etc/profile.d/profile.sh
sudo chmod +x /etc/profile.d/profile.sh

cd /home/$user
[ ! -d "AcuSupport" ] && mkdir -m 775 AcuSupport
cd /home/$user/AcuSupport
[ ! -d "AcuDataFiles" ] && mkdir AcuDataFiles
[ ! -d "AcuLogs" ] && mkdir AcuLogs
[ ! -d "AcuResources" ] && mkdir AcuResources
[ ! -d "AcuSamples" ] && mkdir AcuSamples
[ ! -d "AcuScripts" ] && mkdir AcuScripts
[ ! -d "CustomerPrograms" ] && mkdir CustomerPrograms
[ ! -d "etc" ] && mkdir etc
cd /home/$user/AcuSupport/AcuScripts
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/AcuScripts/setenv.sh
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/AcuScripts/startacu.sh
chmod +x setenv.sh startacu.sh
cd /home/$user/AcuSupport/etc
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/a_srvcfg
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/acurcl.cfg
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/acurcl.ini
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/boomerang.cfg
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/cblconfig
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/fillCombo.js
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/gateway.conf
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/gateway.toml
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/TCPtuning.conf
cd /home/$user/AcuSupport

cd /home/$user
[ ! -d "MFSupport" ] && mkdir -m 775 MFSupport
cd /home/$user/MFSupport
[ ! -d "MFScripts" ] && mkdir MFScripts
[ ! -d "MFSamples" ] && mkdir MFSamples
[ ! -d "MFLicenses" ] && mkdir MFLicenses
cd /home/$user/MFSupport/MFScripts
curl -O https://raw.githubusercontent.com/UNiXMIT/UNiXMF/main/MFScripts/linux/setupmf.sh
curl -O https://raw.githubusercontent.com/UNiXMIT/UNiXMF/main/MFScripts/linux/startmf.sh
chmod +x setupmf.sh startmf.sh
cd /home/$user/AcuSupport
sudo chown -R $user:$user /home/support

(sudo crontab -l ; echo "#0 18 * * * root shutdown -h now")| sudo crontab -
(sudo crontab -l ; echo "@reboot sysctl -p /home/$user/AcuSupport/etc/TCPtuning.conf")| sudo crontab -

. /etc/os-release
echo " " > motd.temp
echo " " >> motd.temp
echo "  $PRETTY_NAME" >> motd.temp
echo " " >> motd.temp
echo "    Set Environment:" >> motd.temp
echo "        . setenv.sh (-h for usage)" >> motd.temp
echo " " >> motd.temp
echo "    Start Services:" >> motd.temp
echo "        startacu.sh (-h for usage)" >> motd.temp
echo " " >> motd.temp
if [[ $(grep microsoft /proc/version) ]] && [ -d "/etc/update-motd.d/" ] ; then
  sudo mv motd.temp /etc/update-motd.d/00-header
else
  sudo mv motd.temp /etc/motd
  sudo sysctl -p /home/$user/AcuSupport/etc/TCPtuning.conf
fi
