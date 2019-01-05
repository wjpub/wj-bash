#!/bin/bash
mysql_remove() {
    echo -e "${SETCOLOR_SUCCESS} start to remove mysql .${RES}"
    apt list  |grep mysql | grep installed | grep ^mysql | cut -d/ -f1 | xargs apt-get autoremove -y
    find / -name mysql | xargs /bin/rm -r
    dpkg -l | grep mysql | grep ^rc | cut -d' ' -f3 | xargs dpkg --purge
    echo "remove mysql done ."
}

mysql_remove
