#!/bin/bash
sudo dnf install nfs-utils -y
sudo systemctl start nfs-server.service
sudo systemctl enable nfs-server.service
sudo systemctl status nfs-server.service
sudo mkdir /mnt/nfs
sudo chown -R nobody: /mnt/nfs
sudo chmod -R 777 /mnt/nfs
sudo systemctl restart nfs-utils.service
echo '/mnt/nfs *(rw,sync,no_subtree_check)' | sudo tee -a /etc/exports
sudo exportfs -arv
sudo exportfs -s