#!/bin/bash
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade
sudo apt autoremove
sudo apt install -y update-manager-core
sudo do-release-upgrade
# force update with -d
# sudo do-release-upgrade -d
sudo sed -i 's/xenial/bionic/g' /etc/apt/sources.list
sudo apt update && sudo apt -y dist-upgrade
exit 0
