#!/bin/bash
sudo apt -y update
sudo apt -y upgrade
sudo apt -y dist-upgrade
sudo apt -y autoremove
sudo apt -y install update-manager-core
sudo do-release-upgrade -y
# force update with -d
# sudo do-release-upgrade -d
sudo sed -i 's/xenial/bionic/g' /etc/apt/sources.list
sudo apt update && sudo apt -y dist-upgrade
exit 0
