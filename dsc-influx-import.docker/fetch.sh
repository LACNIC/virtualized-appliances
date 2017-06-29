[ -z "$1" ] || PROFILE=$1
[ -z "$2" ] || DATE=$2
[ -z "$2" ] || USR=$3

docker run -it -v $(pwd)/data:/data -v ~/.ssh:/keys -e "USR=$USR" --rm lacniclabs/dsc2influx:1.0 /data/bin/fetch_dsc_data.sh /data/bin/$PROFILE.profile $DATE
