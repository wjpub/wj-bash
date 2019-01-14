#!/bin/bash
main_root=`dirname $(readlink -f $0)`
cd "$main_root/"
pwd

#./ubuntu_system_update.sh
#./redis_install.sh
#./nginx_install.sh
#./openresty_install.sh
#./mysql_remove.sh
#./mysql8_install.sh
#./php72_install.sh
#./composer_install.sh
./npm_install.sh
./python_install.sh

apt upgrade
apt update
apt autoremove
