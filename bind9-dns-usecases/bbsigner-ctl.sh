# Boot bind-based signer
#WD=$(pwd)
#echo Booting signer, with base $WD, mounted on /v
#
#/usr/bin/docker run -d --name=cm2c_signer -p 53:53 -p 53:53/udp -v $WD:/v cm2c/nssigner \
#	 /opt/bbsigner/sbin/named -g -d1 -c /v/dfiles/nssigner/named.conf

#!/bin/sh
### BEGIN INIT INFO
# Provides:
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start daemon at boot time
# Description:       Enable service provided by daemon.
### END INIT INFO

dir=$(pwd)
user="root"
cmd="/usr/bin/docker run -d --name=cm2c_signer -p 53:53 -p 53:53/udp -v $dir:/v cm2c/nssigner:1.0  /opt/bbsigner/sbin/named -g -d1 -c /v/dfiles/nssigner/named.conf"

name=`basename $0`
pid_file="$dir/var/$name.pid"
stdout_log="$dir/var/$name.log"
stderr_log="$dir/var/$name.err"
touch $stdout_log
touch $stderr_log

get_pid() {
    #cat "$pid_file"
	tail -1 $stdout_log
}

is_running() {
    #[ -f "$pid_file" ] && ps `get_pid` > /dev/null 2>&1
	pid=$(get_pid)
	dpid=$(docker ps | grep cm2c_signer)
	# echo cid $pid, dpid $dpid
	if [ X = X"$dpid" ]; then
		false
	else
		true
	fi   
}

wait_for_running() {
    for i in {1..10}
    do
        if ! is_running; then
            break
        fi

        echo -n "."
        sleep 1
    done	
}

case "$1" in
    start)
    if is_running; then
        echo "Already started"
    else
        echo "Starting $name"
        cd "$dir"
        sudo -u "$user" $cmd >> "$stdout_log" 2>> "$stderr_log" &
        # echo $! > "$pid_file"
        #if ! is_running; then
        #    echo "Unable to start, see $stdout_log and $stderr_log"
        #    exit 1
        #fi
		wait_for_running
    fi
    ;;
    stop)
    if is_running; then
        echo -n "Stopping $name, cid $(get_pid).."
        #kill `get_pid`
		docker stop $(get_pid)
		docker rm $(get_pid)
        for i in {1..10}
        do
            if ! is_running; then
                break
            fi

            echo -n "."
            sleep 1
        done
        echo

        if is_running; then
            echo "Not stopped; may still be shutting down or shutdown may have failed"
            exit 1
        else
            echo "Stopped"
            if [ -f "$pid_file" ]; then
                rm "$pid_file"
            fi
        fi
    else
        echo "Not running"
    fi
    ;;
    restart)
    $0 stop
    if is_running; then
        echo "Unable to stop, will not attempt to start"
        exit 1
    fi
    $0 start
    ;;
    status)
    if is_running; then
		pid=$(get_pid)
        echo "Running ($name as cid $pid)"
    else
        echo "Stopped"
        exit 1
    fi
    ;;
	build)
	echo "Building docker image cm2c/nssigner:1.0"
	cd dfiles/nssigner
	docker build -t cm2c/nssigner:1.0 .
    *)
    echo "Usage: $0 {start|stop|restart|status|build}"
    exit 1
    ;;
esac

exit 0
