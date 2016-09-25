#!/bin/bash
echo Removing old instances of mynet and creating the new one
docker network rm mynet || /bin/true
docker network create --ipv6 --subnet 2001:13c7:7003:0:300::/80 -d bridge mynet
docker network inspect mynet
#
echo Adding NDP entries
sudo ip -6 neigh add proxy 2001:13c7:7003:0:300::2 dev em1
