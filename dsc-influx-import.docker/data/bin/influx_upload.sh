#!/bin/bash
HOST='influx.dev.lacnic.net'
PORT='8086'
DB='dsc'
INFLUX_USR=''
INFLUX_PASS=''

URL="http://$HOST:$PORT/write?db=$DB"

curl -i -XPOST "http://$HOST:$PORT/write?db=$DB" --data-binary @$1
#curl -i -XPOST "http://$HOST:$PORT/write?db=$DB&u=$INFLUX_USR&p=$INFLUX_PASS" --data-binary @$1
