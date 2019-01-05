#!/bin/bash

php72_install() {
    echo "php7.2 install start..."

    if [ -e /usr/bin/php7.2 ];then 
        echo "php7.2 already exist. stop install."
    else
        echo "exec: apt -y install software-properties-common apt-transport-https lsb-release ca-certificates ...."
        apt -y install software-properties-common apt-transport-https lsb-release ca-certificates
        echo "exec: add-apt-repository ppa:ondrej/php ...."
        add-apt-repository -y ppa:ondrej/php
        echo "exec: apt update ...."
        apt update

        echo "exec: sudo apt-get install php7.2 php7.2-fpm php7.2-xml php7.2-mbstring  php7.2-mysql php7.2-zip php7.2-curl ...."
        sudo apt-get -y install php7.2 php7.2-fpm php7.2-xml php7.2-mbstring  php7.2-mysql php7.2-zip php7.2-curl
        sed -i "s/;date.timezone =/date.timezone = \"PRC\"/g" /etc/php/7.2/fpm/php.ini
        echo "php7.2 install completed. "
    fi
}

php72_install
