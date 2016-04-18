# Boot bind-based signer
# WD=/vagrant
WD=$(pwd)
INSTANCE=$1
CONT_NAME="cm2c_$INSTANCE"
HOST_PORT="192.168.1.10:53"
# echo "# Booting bind instance $INSTANCE, with base $WD, mounted on /v"

cd $WD

# removing previous instances of the container, if any
# echo "# removing previous instances of the container, if any"
N=$(/usr/bin/docker rm -f $CONT_NAME)
echo J=$J\;
echo export J\;

# echo "# starting new instance"
J=$(/usr/bin/docker run -d --name=$CONT_NAME -p $HOST_PORT:5301 -p $HOST_PORT:5301/udp -v $WD:/v cm2c/basebind9:1.0 \
 /opt/bbsigner/sbin/named -4 -g -c /v/dfiles/$INSTANCE/named.conf)
echo J=$J\;
echo export J\;
echo echo $CONT_NAME started\;
