#!/bin/bash
#set -x
status=$(sudo su - root -c "ceph -s")

if [ "$1" == "osd-status" ]; then
        exist=`echo "$status" | grep 'osds:' | awk -F ' osds: ' '{print $1}' | awk -F 'osd: ' '{print $2}'` # | awk -F ' up' '{print $1}'`
        up=`echo "$status" | grep 'osds:' | awk -F ' osds: ' '{print $2}' | awk -F 'up, ' '{print $1}'`
        if [ "$up" -eq "$exist" ]; then
                echo "OK - OSD Present: ${exist} | OSD Up: ${up}"
                exit 0;
        elif [ "$(expr $exist - $up)" -ge "$2" ] && [ $(expr $exist - $up) -lt $2 ]; then
                echo "WARNING - OSD Present: ${exist} | OSD Up: ${up}"
                exit 1;
        elif [ "$(expr $exist - $up)" -ge "$3" ]; then
                echo "CRITICAL - OSD Present: ${exist} | OSD Up: ${up}"
                exit 2;
        else
                echo "UNKNOWN - Couldn't do math."
                exit 3;
        fi
elif [ "$1" == "health" ]; then
        health=`echo "$status" | grep 'health:' | awk '{print $2}'`
        if [ "$health" == "HEALTH_WARN" ]; then
                printf "WARNING - "
                echo "$status" | grep 'health:' -A 2 | tail -n 2
                exit 1
        elif [ "$health" == "HEALTH_OK" ]; then
                echo "OK"
                exit 0
        elif [ "$health" == "HEALTH_ERR" ]; then
                printf "CRITICAL - "
                echo "$status" | grep 'health:' -A 2 | tail -n 2
                exit 2
        fi
fi
