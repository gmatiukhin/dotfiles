#!/usr/bin/env bash

socat - "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" \
  | while read -r line; do echo $line; done
