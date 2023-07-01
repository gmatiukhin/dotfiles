#!/bin/env bash
xkb-switch -s us # switch to latin keyboard before locking
convert $HOME/.config/i3/background/cory-billett-luthadel-bt2.jpg RGB:- \
  | i3lock --nofork --ignore-empty-password --raw 1920x1080:rgb --image /dev/stdin
