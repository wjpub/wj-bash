#!/bin/bash

nginx_install() {
    echo "nginx install start."

    if [ -e /usr/sbin/nginx ];then
        echo "nginx already exist."
    else
        echo "exec: remove apache ...."
        apt-get --purge remove -y apache*
        find /etc -name "*apache*" |xargs  /bin/rm -rf
        dpkg -l |grep apache|awk '{print $2}'|xargs dpkg -P
        echo "exec: sudo apt install nginx ...."
        apt install -y nginx
    fi
    echo "exec: service nginx restart ...."
    service nginx restart
    echo "nginx install completed."
}

nginx_install
