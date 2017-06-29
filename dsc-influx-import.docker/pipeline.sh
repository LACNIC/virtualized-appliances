[ -z "$1" ] || PROFILE=$1
[ -z "$2" ] || DATE=$2
[ -z "$2" ] || USR=$3

USR=$USR DATE=$DATE PROFILE=$PROFILE ./fetch.sh && \
DATE=$DATE PROFILE=$PROFILE ./process.sh  &>/dev/null && \
DATE=$DATE PROFILE=$PROFILE ./post.sh
