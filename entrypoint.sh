#!/bin/bash

contains() {
  local e match="$1"; shift
  for e; do [[ "$e" == "$match" ]] || [[ "$e" =="$match="* ]] && return 0; done
  return 1
}

valueof() {
  local e match="$1"; shift
  for e; do
    if [[ "$e" =="$match="* ]]; then
      echo "$e" | cut -d '=' -f2-
      return 0
    fi
  done
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
echo "127.0.1.1" "$(hostname)" >> /etc/hosts
IFS=','
read -a options <<< "$3"
shift 3
if ! contains setup "${options[@]}"; then
  cd ~ubuntu
  if contains wayland "${options[@]}"; then
    export WAYLAND_DISPLAY=/wayland
  fi
  if contains xorg "${options[@]}"; then
    export DISPLAY=$(valueof xorg "${options[@]}")
    export XAUTHORITY=~ubuntu/.Xauthority
  fi
  exec sudo -u ubuntu "$@"
else
  exec "$@"
fi
