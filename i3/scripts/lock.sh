#!/bin/env bash
amixer set Master mute # turn off volume
xkb-switch -s us # switch to latin keyboard before locking
convert $HOME/.config/i3/background/cory-billett-luthadel-bt2.jpg RGB:- \
  | i3lock --nofork --ignore-empty-password --raw 1920x1080:rgb --image /dev/stdin
