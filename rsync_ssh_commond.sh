#!/bin/bash

# aliyun
cd /home/wwwroot/tagging;
# rsync project files
rsync -azq eva --exclude "*/config/*" --exclude "*/runtime/*" --exclude ".git/*" root@47.94.215.179:/home/wwwroot/eva_dcm/
rsync -azq eva_frontend --exclude "*/dist" --exclude ".git/*" root@47.94.215.179:/home/wwwroot/eva_dcm/
# build project on remote
ssh root@47.94.215.179 "cd /home/wwwroot/eva_dcm/eva_frontend/; npm run generate.public; exit"

# 61
rsync -azq eva --exclude "*/config/*" --exclude "*/runtime/*" --exclude ".git/*" --exclude "vender/*" --exclude "composer.lock" root@192.168.10.61:/home/wwwroot/tagging/
rsync -azq eva_frontend --exclude ".git/*" root@192.168.10.61:/home/wwwroot/tagging/
