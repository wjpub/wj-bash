#!/bin/bash

# log cut and compress
# default error.log access.log
log_file_path=(
     '/var/log/www/'
)

# get date str
date_str=$(date -d "1 day ago" +"%Y%m%d")
date_old=$(date -d "30 days ago" +"%Y%m%d")
# echo ${date_str} ${date_old}
# nginx pid
pid_path="/usr/local/nginx/logs/nginx.pid"

function cut_press()
{
    #echo $1
    if [ ! -f "$1" ]; then
          return;
     fi
     filename=$(basename $1)
     filedir=$(dirname $1)
     cd "$filedir"
     mv $filename $date_str$filename
     tar -zcf $date_str$filename".tar.gz" $date_str$filename --remove-files
     if [ -f $date_old$filename".tar.gz" ]; then
          rm -f $date_old$filename".tar.gz"
     fi
}

# echo ${date_str}

for log_path in ${log_file_path[@]}; do
     if [ -d "$log_path" ]; then
          #echo 'dir'
          cut_press ${log_path}access.log
          cut_press ${log_path}error.log
          cut_press ${log_path}run.log
          cut_press ${log_path}script.log
     else
          #echo 'file'
          cut_press ${log_path}
     fi
done

# 向nginx主进程发信号重新打开日志
kill -USR1 `cat ${pid_path}`
