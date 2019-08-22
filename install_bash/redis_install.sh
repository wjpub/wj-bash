#!/bin/bash

redis_install() {
    echo " redis install start."

    if [ -e /usr/bin/redis-server ];then
        echo "redis already exist ."
    else
        echo "exec: apt-get install -y redis-server redis-tools ...."
        apt-get install -y redis-server redis-tools
    fi
    echo "exec: service redis-server restart ...."
    service redis-server restart
    echo "redis install completed."
}

redis_install
