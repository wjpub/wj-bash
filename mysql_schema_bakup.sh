#!/bin/sh
dbs=('database1' 'database2')

mysql_bin='/usr/local/mysql/bin'
dbbak_dir='/data1/backup'

month=`date +%Y%m`
day=`date +%m%d`
date_format=`date +%Y%m%d`

for db in ${dbs[@]}; do
    mkdir -p $dbbak_dir/$month/$day
    $mysql_bin/mysqldump -uroot -ppassword --opt $db | gzip > $dbbak_dir/$month/$day/$db\_$date_format.sql.gz
    sleep 1
done

