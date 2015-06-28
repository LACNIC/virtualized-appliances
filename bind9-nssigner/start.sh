# Boot bind-based signer
WD=$(pwd)
echo Booting signer, with base $WD, mounted on /v

/usr/bin/docker run -d --name=cm2c_signer -p 53:53 -p 53:53/udp -v $WD:/v cm2c/nssigner \
	 /opt/bbsigner/sbin/named -g -d1 -c /v/dfiles/nssigner/named.conf

