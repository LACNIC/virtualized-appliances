# Boot bind-based signer
WD=/vagrant
INSTANCE=$1
CONT_NAME="cm2c_$INSTANCE"
echo Booting bind instance $INSTANCE, with base $WD, mounted on /v

cd $WD

# removing previous instances of the container, if any
echo === removing previous instances of the container, if any
/usr/bin/docker rm -f $CONT_NAME

echo === starting new instance
/usr/bin/docker run -d --name=$CONT_NAME -p 5301:5301 -p 5301:5301/udp -v $WD:/v cm2c/basebind9:1.0 \
	 /opt/bbsigner/sbin/named -g -c /v/dfiles/$INSTANCE/named.conf

