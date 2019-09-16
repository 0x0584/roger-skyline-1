#!/bin/sh

INTERFACES=/etc/network/interfaces

LOCAL_IF=enp0s3
NETMASK=255.255.255.252
LOCAL_IP=$(ifconfig $LOCAL_IF | grep 'inet ' | awk '{print $2}')
LOCAL_GATEWAY=$(traceroute 8.8.8.8 | head -3 | \
					grep 'traceroute' -A 1 | grep -v 'traceroute' \
					| awk '{print $2}')

sed -i "/iface $LOCAL_IF/ s/dhcp/static/" $INTERFACES
echo "address $LOCAL_IP" >> $INTERFACES
echo "netmask $NETMASK" >> $INTERFACES
echo "gateway $LOCAL_GATEWAY" >> $INTERFACES
