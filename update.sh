#!/bin/sh

function check_online
{
    netcat -z -w 5 8.8.8.8 53 && echo 1 || echo 0
}

IS_ONLINE=check_online
MAX_CHECKS=5
CHECKS=0

while [ $IS_ONLINE -eq 0 ]; do
    sleep 10;
    IS_ONLINE=check_online
    CHECKS=$[ $CHECKS + 1 ]
    if [ $CHECKS -gt $MAX_CHECKS ]; then
        break
    fi
done

if [ $IS_ONLINE -eq 0 ]; then
    exit 1
fi

apt-get update -y >> /var/log/update.log
apt-get upgrade -y >> /var/log/update.log

exit 0
