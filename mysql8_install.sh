#!/bin/bash
SETCOLOR_SUCCESS="\E[1;31m"
RES='\E[0m'
mysql8_install() {
    if [ -e /usr/bin/mysql ];then
        echo "mysql exist ."
        exit 1
    fi
    echo "select 'OK' to continue in next step ."
    sleep 10
    wget https://repo.mysql.com/mysql-apt-config_0.8.10-1_all.deb
    dpkg -i mysql-apt-config_0.8.10-1_all.deb
    sudo apt-get update
    echo "input mysq root password and stronge level to continue in next step ."
    sleep 10
    sudo apt-get install -y mysql-server mysql-client libmysqlclient-dev
    echo 'default-time-zone = "+08:00"' >> /etc/mysql/mysql.conf.d/mysqld.cnf
    sudo service mysql restart
    echo "mysql8 install finish."
}

mysql8_install
