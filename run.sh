#!/usr/bin/env bash
DELETE=0
LOGGING=0
STOP=0

usage()
{
    cat <<EOF
Usage :$0 [options]
-d    Delete the container after stopping (requires -l and -s)
-h    Prints this help text and exits
-l    Connects to the container logs after starting
-s    Stop the container after logging is exite (requires -l)
EOF
}
while getopts dhls opt; do
    case $opt in
        h)
            usage
            exit 1
            ;;
        d)
            DELETE=1
            ;;
        l)
            LOGGING=1
            ;;
        s)
            STOP=1
            ;;
    esac
done
if [ -d "$PWD/recordings" ]; then
    chmod 777 $PWD/recordings
else
    mkdir $PWD/recordings
    chmod 777 $PWD/recordings
fi
if hash docker-compose 2>/dev/null; then
    # Run our server
    docker-compose up -d
    if [ $LOGGING = 1 ]; then
        docker-compose logs --follow --timestamps
        if [ $STOP = 1 ]; then
            docker-compose stop
            if [ $DELETE = 1 ]; then
                docker-compose rm -vf
            fi
        fi
    fi
else
    echo "docker-compose is not installed, please install it before running"
    exit 1
fi
