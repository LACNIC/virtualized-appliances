#!/bin/bash

axfr_servers="k.root-servers.net b.root-servers.net f.root-servers.net"
success=0
echo '' > db.root

for R in $axfr_servers
do
	echo Trying root axfr from $R
	/opt/bbsigner/bin/dig @$R axfr . > db.root
	size=$(stat -c%s db.root)
	if (( size > 1500000 )); then
		echo File size is $size, seems OK!
		success=1
		break
	fi 
done

if (( success == 1 )); then
	echo Root zone successfully AXFRed
	exit 0
else
	echo Root zone AXFR failed!
	exit 1
fi

