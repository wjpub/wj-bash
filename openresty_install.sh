#!/bin/bash

openresty_install() {
    echo "openresty install start..."

    if [ -e /usr/bin/openresty ];then 
        echo "openresty already exist. stop install."
    else
        echo "import openresty GPG apt-key"
        wget -qO - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
        echo "install add-apt-repository" 
        sudo apt-get -y install software-properties-common
        echo "add openresty org apt-repository"
        sudo add-apt-repository -y "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main"
        echo "apt update"
        sudo apt-get update
        echo "install openresty"
        sudo apt-get install openresty
        # echo "install without default pkg: openresty-opm  openresty-restydoc
        # sudo apt-get install --no-install-recommends openresty
    fi
}

openresty_install

