[ -z "$1" ] || PROFILE=$1
[ -z "$2" ] || DATE=$2

docker run -it -v $(pwd)/data:/data --rm lacniclabs/dsc2influx:1.0 /data/bin/influx_upload.sh /data/var/$PROFILE/influx/influx_$DATE.txt
