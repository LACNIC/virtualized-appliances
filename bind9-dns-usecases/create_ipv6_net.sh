#!/bin/bash
docker network rm mynet || /bin/true
docker network create --ipv6 --subnet 2001:13c7:7003:0:300::/80 -d bridge mynet
docker network inspect mynet
