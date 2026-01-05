#!/bin/bash

contains() {
  local e match="$1"; shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

if [ -f "/.firstrun" ]; then
    targetuid="$1"
    targetgid="$2"
    rm -rf /home/ubuntu
    groupadd -g "$2" ubuntu
    useradd -u "$1" -g "$2" -m ubuntu
    rm -f /.firstrun
fi
IFS=','
read -a options <<< "$3"
shift 3
if ! contains setup "${options[@]}"; then
  cd ~ubuntu
  exec sudo -u ubuntu "$@"
else
  exec "$@"
fi
