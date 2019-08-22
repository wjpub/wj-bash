#!/bin/bash

set_ulimit() {
    echo '
fs.file-max = 131072' >> /etc/sysctl.conf
    sysctl -p
    echo '
* soft     nproc          131072
* hard     nproc          131072
* soft     nofile         131072
* hard     nofile         131072
root soft     nproc          131072    
cat root hard     nproc          131072
root soft     nofile         131072
root hard     nofile         131072
' >> /etc/security/limits.conf

    echo '
session required pam_limits.so
' >> /etc/pam.d/common-session
    # Log out and in and try ulimit -n
}

set_net_conn() {
    echo '
net.core.somaxconn = 20480
net.core.rmem_default = 262144
net.core.wmem_default = 262144
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 4096 16777216
net.ipv4.tcp_wmem = 4096 4096 16777216
net.ipv4.tcp_mem = 786432 2097152 3145728
net.ipv4.tcp_max_syn_backlog = 16384
net.core.netdev_max_backlog = 20000
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_max_orphans = 131072
net.ipv4.tcp_syncookies = 0

'>> /etc/sysctl.conf
    # 以下配置部分效果同上
    echo 20480 > /proc/sys/net/core/somaxconn
    echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
    echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle
    echo 0 > /proc/sys/net/ipv4/tcp_syncookies

    sysctl -p
}

set_nginx_conf() {
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
    cp nginx/nginx.conf /etc/nginx.conf
    mkdir /etc/nginx/conf.d
    cp nginx/server.conf /etc/nginx/conf.d/server.conf.sample
    
}

set_php_conf() {
    mv /etc/php/7.2/fpm /etc/php/7.2/fpm_bak
    cp -r /php/fpm /etc/php/7.2/fpm
    apt install php7.2-opcache
    sed -i "s/--nodaemonize --fpm-config/--nodaemonize --allow-to-run-as-root --fpm-config/" /lib/systemd/system/php7.2-fpm.service
}

set_mysql8_conf() {
    echo '
max_connections=4096
' >> /etc/mysql/mysql.conf.d/mysqld.cnf
}


set_ulimit
set_net_conn
set_nginx_conf
set_php_conf
set_mysql8_conf

service nginx restart
service mysql restart
service php7.2-fpm restart
