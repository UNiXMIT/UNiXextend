#!/bin/bash

read -p "User to create: " user
read -p "${user} password to set: " upasswd
if id "$user" >/dev/null 2>&1; then
    echo $user user found, continuing...
else
    sudo adduser support
fi
echo "root:$upasswd" | sudo chpasswd
echo "$user:$upasswd" | sudo chpasswd
echo "if [[ -t 0 && $- = *i* ]]; then stty -ixon; fi" >> /home/$user/.bashrc
if [[ -f /etc/ssh/sshd_config ]]; then
  sudo sed -i -E 's/#?AllowTcpForwarding no/AllowTcpForwarding yes/' /etc/ssh/sshd_config;
  sudo sed -i -E 's/#?PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config;
fi
echo $user' ALL=(ALL:ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo
sudo service ssh restart &>/dev/null
sudo service sshd restart &>/dev/null  

if command -v dnf >/dev/null; then
  sudo dnf update -y;
  sudo dnf group install -y "Development Tools";
  . /etc/os-release;
  sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-${VERSION_ID%.*}.noarch.rpm;
  if [[ ${VERSION_ID%.*} -le 8 ]]; then
    sudo dnf install -y --skip-broken libnsl podman buildah unixODBC-devel wget curl cronie dos2unix java-11-openjdk htop tmux libstdc++.i686 libxcrypt.i686 ncurses-libs-6.1-9.20180224.el8.i686 libaio-devel glibc.i686 zlib-1.2.11-18.el8_5.i686 tcpdump ed glibc-devel.i686 spax jq;
  elif [[ ${VERSION_ID%.*} -ge 9 ]]; then
    sudo dnf install -y --skip-broken libnsl podman buildah unixODBC-devel wget curl cronie dos2unix java-11-openjdk htop tmux libstdc++.i686 libxcrypt-compat-4.4.18-3.el9.i686 ncurses-libs-6.1-9.20180224.el8.i686 libaio-devel glibc.i686 zlib-1.2.11-39.el9.i686 tcpdump ed glibc-devel.i686 procps jq;
  fi
    sudo setenforce 0;
    sudo sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config;
elif command -v apt >/dev/null; then
  . /etc/os-release
  sudo apt update;
  sudo apt upgrade -y;
  sudo dpkg --add-architecture i386;
  sudo apt install -y -m build-essential podman buildah unixodbc-dev wget curl cron dos2unix default-jdk htop tmux lib32stdc++6 libaio-dev libncurses5 apt-file zlib1g:i386 tcpdump libgc1 pax jq;
  sudo apt-file update;
elif command -v zypper >/dev/null; then
  sudo zypper refresh;
  sudo zypper update -y;
  sudo zypper install -y -t pattern devel_C_C++;
  sudo zypper install -y cronie podman buildah unixODBC-devel wget curl dos2unix glibc-32bit java-11-openjdk htop tmux libcrypt1-32bit libncurses5-32bit libaio-devel libstdc++6-32bit libgcc_s1-32bit libz1-32bit tcpdump ed spax jq;
else
  echo "Install CMD not identified"
fi
sudo systemctl enable --now podman.socket

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
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/AcuScripts/setenvacu.sh
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/AcuScripts/startacu.sh
chmod +x setenvacu.sh startacu.sh
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
[ ! -d "MFInstallers" ] && mkdir MFInstallers
[ ! -d "MFDataFiles" ] && mkdir MFDataFiles
cd /home/$user/MFSupport/MFScripts
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXMF/main/linux/MFScripts/setupmf.sh
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXMF/main/linux/MFScripts/startmf.sh
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXMF/main/linux/MFScripts/setenvmf.sh
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXMF/main/linux/MFScripts/formatdumps.sh
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXMF/main/linux/MFScripts/autopac.sh
chmod +x setupmf.sh startmf.sh setenvmf.sh formatdumps.sh autopac.sh
cd /home/$user/AcuSupport
sudo chown -R $user:$user /home/support

(sudo crontab -l ; echo "#0 20 * * * shutdown -h now")| sudo crontab -
(sudo crontab -l ; echo "@reboot sysctl -p /home/$user/AcuSupport/etc/TCPtuning.conf")| sudo crontab -

. /etc/os-release
cat > motd.temp <<EOF
****************************************************************************************************

    $PRETTY_NAME

    AcuCOBOL
      Set Environment:
        . setenvacu.sh (-h for usage)
          
        startacu.sh (-h for usage)

    MFCOBOL
      Set Environment:
        . setenvmf.sh

        startmf.sh (-h for usage)

      Install Options:
        -skipsafenet -skipautopass -IacceptEULA -ESadminID=${user} -il=/home/products/esXXpuXX

****************************************************************************************************
EOF
sudo mv motd.temp /etc/motd
if [[ $(grep microsoft /proc/version) ]]; then
  echo "cat /etc/motd" >> /etc/profile.d/profile.sh
  sudo cat > /etc/wsl.conf <<EOF
[boot]
systemd=true
[user]
default=${user}
EOF
else
  sudo sysctl -p /home/$user/AcuSupport/etc/TCPtuning.conf
fi
