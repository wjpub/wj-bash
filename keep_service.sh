#!/bin/bash
service_names=('mysql' 'nginx' 'php-fpm' 'cron')
for service_name in ${service_names[@]}; do
    service_pid=`ps -aux | grep -w $service_name | grep -v grep | grep -v dcm | awk '{print $2}'`
    if [ "$service_pid" = "" ]; then
        echo "$service_name need start and starting..."
        service_pid=`/etc/init.d/$service_name start`
        echo "start done: $service_pid" 
    else
        echo $service_name is running_$service_pid
    fi
done
echo cur pid $$
