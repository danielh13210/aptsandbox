#!/bin/bash

if [ -f "/.firstrun" ]; then
    targetuid="$1"
    targetgid="$2"
    groupadd -g "$2" ubuntu
    useradd -u "$1" -g "$2" -m ubuntu
    rm -f /.firstrun
fi
shift 2
cd ~ubuntu
exec sudo -u ubuntu "$@"