#!/bin/bash
# SERVER="ns2"
# NODE="gru01"
# FECHA="2017-05-09"
echo SOURCING PROFILE $1 for DATE $2
source $1
FECHA=$2
XMLDIR="/data/var/$SERVER/$FECHA"
OUTPUTDIR="/data/var/$SERVER/influx"
#XML="/data/ns2/1494374340.dscdata.xml"
mkdir -p $OUTPUTDIR
for XML in $(ls -1 $XMLDIR/*xml)
do
  perl -I"$HOME/dsc-datatool/lib" "$HOME/dsc-datatool/bin/dsc-datatool" \
    --server "$SERVER" \
    --node "$NODE" \
    --output ";InfluxDB;file=/tmp/influx_$FECHA-$(basename $XML)-$SERVER.txt;dml=1;database=dsc" \
    --transform ";Labler;*;yaml=$HOME/labler.yaml" \
    --transform ";ReRanger;rcode_vs_replylen;range=/64;pad_to=5" \
    --transform ";ReRanger;qtype_vs_qnamelen;range=/16;pad_to=3" \
    --transform ";ReRanger;client_port_range;key=low;range=/2048;pad_to=5" \
    --transform ";ReRanger;edns_bufsiz,priming_queries;key=low;range=/512;pad_to=5;allow_invalid_keys=1" \
    --transform ";ReRanger;priming_responses;key=low;range=/128;pad_to=4" \
    --transform ";NetRemap;client_subnet,client_subnet2,client_addr_vs_rcode,ipv6_rsn_abusers;net=8" \
    --generator client_subnet_country,client_subnet_authority \
    --xml "$XML"
done

echo CONCATENANDO LAS PARTES DE LA FECHA $FECHA
OFILE="$OUTPUTDIR/influx_$FECHA.txt"
echo -n "" > $OFILE
for F in $(ls -1 /tmp/influx_$FECHA-*-$SERVER.txt)
do
  cat $F >> $OFILE
done

ls -lh $OFILE
