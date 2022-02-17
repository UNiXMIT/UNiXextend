#!/bin/bash
sudo ip addr flush dev eth0
sudo ip addr add 10.0.0.254/24 dev eth0
sudo ip link set eth0 up
sudo ip route add default via 10.0.0.1 dev eth0
sudo echo nameserver 1.1.1.1 > /etc/resolv.conf
sudo echo [network] > /etc/wsl.conf
sudo echo generateResolvConf = false >> /etc/wsl.conf