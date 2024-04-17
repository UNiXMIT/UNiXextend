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

# Client Setup
## sudo dnf install nfs-utils nfs4-acl-tools -y
## showmount -e serverHostOrIP
## sudo mkdir p /mnt/nfs
## sudo mount -t nfs serverHostOrIP:/mnt/nfs /mnt/nfs
# Persistent NFS Mount
## echo 'serverHostOrIP:/mnt/nfs  /mnt/nfs  nfs  defaults  0  0' /etc/fstab | sudo tee -a /etc/fstab

# Enable Quotas
## echo 'serverHostOrIP:/mnt/nfs  /mnt/nfs  nfs  defaults,usrquota 0 0' /etc/fstab | sudo tee -a /etc/fstab
## sudo quotacheck -cug /mnt/nfs
## sudo edquota -u username
## sudo quotaon /mnt/nfs
## quota -u username