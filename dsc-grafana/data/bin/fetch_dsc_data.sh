#!/bin/bash
source $1
export RSYNC_RSH="ssh -v -i /data/bin/carlosm-lacnic2 -o PubkeyAcceptedKeyTypes=+ssh-dss"
LINEAS=$(rsync -avz -l $SRC/$2 | awk '!(NR % 24) {print $SRC,"/",$5}')
echo $LINEAS
# rsync -avz $SRC/$2 $DST
