#!/bin/sh
# This script checks if the container is started for the first time.

CONTAINER_FIRST_STARTUP="CONTAINER_FIRST_STARTUP"

if [ ! -e /opt/pgtde/$CONTAINER_FIRST_STARTUP ]; then
    touch /opt/pgtde/$CONTAINER_FIRST_STARTUP
    # place your script that you only want to run on first startup.
    ./initdb.sh
else
    ./start.sh
fi

tail -f /dev/null