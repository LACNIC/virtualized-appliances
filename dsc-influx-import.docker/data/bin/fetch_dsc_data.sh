#!/bin/bash
source $1
export RSYNC_RSH="ssh -v -i /keys/id_rsa_dsc -o PubkeyAcceptedKeyTypes=+ssh-dss -o StrictHostKeyChecking=no"
# LINEAS=$(rsync -avz -l $SRC/$2 | awk "!(NR % 24) {print $SRC,"/",$5}")
LINEAS=$(rsync -avz -l $SRC/$2 $DST)
