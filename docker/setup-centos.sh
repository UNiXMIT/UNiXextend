#!/bin/bash

# Installing Docker
sudo yum check-update
curl -fsSL https://get.docker.com/ | sh
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

# Executing Docker Command Without Sudo (Optional)
# sudo usermod -aG docker $(whoami)

# Source
# https://do.co/2qVaXdf

# View ALL containers
# docker ps -a

# Command
# curl -s https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/docker/setup-centos.sh | bash
