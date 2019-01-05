#!/bin/bash

npm_install() {
    echo "node npm install start."
    apt install -y npm
    npm install npm@latest -g
    npm install -g n
    n latest
    echo "npm install completed."
}

npm_install
