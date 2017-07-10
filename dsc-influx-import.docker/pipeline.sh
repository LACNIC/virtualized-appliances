echo $@

[ -z "$1" ] || PROFILE=$1
[ -z "$2" ] || DATE=$2
[ -z "$3" ] || USR=$3

[ "$DATE" == 'yesterday' ] && DATE=$(docker run -t -v $(pwd)/data:/data --rm lacniclabs/dsc2influx:1.0 date +%Y-%m-%d -d 'yesterday' | cut -c -10)

USR=$USR DATE=$DATE PROFILE=$PROFILE ./fetch.sh && \
DATE=$DATE PROFILE=$PROFILE ./process.sh  &>/dev/null && \
DATE=$DATE PROFILE=$PROFILE ./post.sh
