#!/bin/bash

composer_install() {
    echo "install composer start..."

    if [ -e /usr/local/bin/composer ];then 
        echo "composer already exist."
    else
        echo "exec: curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer ...."
        curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
        echo "exec: composer global require 'fxp/composer-asset-plugin:^1.2.0' ...."
        composer global require "fxp/composer-asset-plugin:^1.2.0"
        echo "composer install comp;eted ."
    fi
}

composer_install
