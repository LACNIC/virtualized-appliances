#!/bin/bash
# Boot docker container for a specific DNS 'use case'
# WD=/vagrant
# WD=$(pwd)
# WD=$(dirname $0)
WD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INSTANCE=$1
CONFIG_FILE=$2
CONT_NAME="cm2c_$INSTANCE"
HOST_PORT="53"
DOCKER_BIN="/usr/bin/docker"
# DOCKER_OPTS="--mac-address='80:00:00:00:00:01'"
BIND_OPTS="-g -c /v/dfiles/$INSTANCE/$CONFIG_FILE"
# echo "# Booting bind instance $INSTANCE, with base $WD, mounted on /v"

cd $WD

# removing previous instances of the container, if any
# echo "# removing previous instances of the container, if any"
N=$($DOCKER_BIN rm -f $CONT_NAME)
echo J=$J\;
echo export J\;

# echo "# starting new instance"
J=$($DOCKER_BIN run $DOCKER_OPTS --name=$CONT_NAME -p $HOST_PORT:53 -p $HOST_PORT:53/udp -v $WD:/v cm2c/basebind9:1.0 \
 /opt/bbsigner/sbin/named $BIND_OPTS)
echo J=$J\;
echo export J\;
echo echo $CONT_NAME started\;
