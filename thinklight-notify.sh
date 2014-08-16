#!/bin/bash

# thinklight-notify.sh
#
# A utility to flash your Thinkpad's thinklight, designed for IM notifications.
# 
# Requires $LIGHTPATH to be writable by your current user.

export LOCKFILE='/tmp/thinklight-lock.lock'
export LIGHTPATH='/sys/class/leds/tpacpi::thinklight/brightness'

function lightoff {
    echo 0 > $LIGHTPATH
}

function lighton {
    echo 255 > $LIGHTPATH
}

function flash {
    if [ -f LOCKFILE ]; then exit -1; fi

    /usr/bin/touch $LOCKFILE

    for x in `/usr/bin/seq 0 2`; do lighton; sleep 0.75; lightoff; sleep 0.75; done
    
    /bin/rm $LOCKFILE
}

flash
