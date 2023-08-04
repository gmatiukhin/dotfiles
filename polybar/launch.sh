#!/usr/bin/env bash

polybar-msg cmd quit

case $(hostname) in
  "Mercury")
    polybar pc 2>&1 | tee -a /tmp/pc_bar.log & disown
    ;;
  "Ganymede")
    polybar laptop 2>&1 | tee -a /tmp/laptop_bar.log & disown
    ;;
esac
  
