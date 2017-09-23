[ -z "$1" ] || PROFILE=$1
[ -z "$2" ] || DATE=$2
[ -z "$3" ] || USR=$3

[ -t 1 ] && DOCKER_OPTS='-ti' || DOCKER_OPTS=''

docker run -v $(pwd)/data:/data -v ~/.ssh:/keys -e "USR=$USR" $DOCKER_OPTS --rm lacniclabs/dsc2influx:1.0 /data/bin/fetch_dsc_data.sh /data/bin/$PROFILE.profile $DATE
