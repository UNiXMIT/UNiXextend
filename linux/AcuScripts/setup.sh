#!/bin/bash

if command -v yum >/dev/null; then
  sudo yum update;
  sudo dnf group install -y "Development Tools";
  sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm;
  sudo yum install -y libnsl podman unixODBC wget curl dos2unix java-11-openjdk htop tmux libstdc++.i686 libxcrypt.i686 ncurses-compat-libs libaio-devel glibc.i686;
  sudo ln -s /usr/lib64/libncurses.so.6 /usr/lib64/libncurses.so.5;
  sudo setenforce 0;
  sudo sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config;
elif command -v apt >/dev/null; then
  . /etc/os-release
  sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
  wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O- | sudo apt-key add -
  sudo apt update;
  sudo apt upgrade -y;
  sudo dpkg --add-architecture i386;
  sudo apt install -y build-essential podman unixodbc-dev wget curl dos2unix default-jdk htop tmux libstdc++6:i386 libc6:i386 lib32stdc++6 libaio-dev libncurses5-dev libncursesw5-dev;
  sudo setenforce 0;
  sudo sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config;
elif command -v zypper >/dev/null; then
  sudo zypper refresh;
  sudo zypper update -y;
  sudo zypper install -y -t pattern devel_C_C++;
  sudo zypper install -y cronie podman unixODBC wget curl dos2unix java-11-openjdk htop tmux libaio-devel libstdc++6-32bit;
else
  echo "Install CMD not identified"
fi

echo "if [[ -t 0 && $- = *i* ]]; then stty -ixon; fi" >> ~/.bashrc

cd /home
sudo mkdir products
sudo chown $(whoami):$(id -gn) products
sudo chmod 755 products

cd ~
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/AcuScripts/profile.sh
sudo mv profile.sh /etc/profile.d/profile.sh
sudo chmod +x /etc/profile.d/profile.sh

cd ~
mkdir AcuSupport
chmod 775 AcuSupport
cd ~/AcuSupport
mkdir AcuDataFiles AcuLogs AcuResources AcuSamples AcuScripts CustomerPrograms etc
cd ~/AcuSupport/AcuScripts
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/AcuScripts/setenv.sh
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/AcuScripts/startacu.sh
chmod +x setenv.sh startacu.sh
cd ~/AcuSupport/etc
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/a_srvcfg
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/acurcl.cfg
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/acurcl.ini
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/boomerang.cfg
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/cblconfig
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/cblconfig_ThinClient
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/fillCombo.js
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/gateway.conf
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/linux/etc/gateway.toml
cd ~/AcuSupport

echo "#0 18 * * * root shutdown -h now" >> ~/AcuSupport/sudo-crontab
sudo crontab ~/AcuSupport/sudo-crontab
rm ~/AcuSupport/sudo-crontab

# sudo echo " " > /etc/motd
# sudo echo " " > /etc/motd
# sudo echo "    Set Environment:" >> /etc/motd
# sudo echo "        . setenv.sh (-h for usage)" >> /etc/motd
# sudo echo " " >> /etc/motd
# sudo echo "    Start Services:" >> /etc/motd
# sudo echo "        startacu.sh (-h for usage)" >> /etc/motd