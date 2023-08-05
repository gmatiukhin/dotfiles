#!/usr/bin/env bash

colors_file=~/.config/polybar/colors.ini

local_ip_color=$(awk -F "=" '/primary/ {print $2}' $colors_file | tr -d ' ')
public_ip_color=$(awk -F "=" '/secondary/ {print $2}' $colors_file | tr -d ' ')
country_color=$(awk -F "=" '/accent/ {print $2}' $colors_file | tr -d ' ')


show_local_ip=1

get_pub_ip() {
    pub_ip=$(curl --silent icanhazip.com)
    cc=$(
    curl --silent "http://ip-api.com/json/${pub_ip}" |
      jq --raw-output .countryCode
    )

    echo "%{F${public_ip_color}}${pub_ip}%{F-} %{F${country_color}}(${cc})"
}

get_loc_ip() {
  echo "%{F${local_ip_color}}$(hostname -i | awk '{print $1}')"
}

change_ip_mode() {
  if [[ $show_local_ip -eq 1 ]]; then
    show_local_ip=0
    get_pub_ip
  else
    show_local_ip=1
    get_loc_ip
  fi
}

trap "change_ip_mode" SIGRTMIN+11

while true; do
  if [[ $show_local_ip -eq 1 ]]; then
    get_loc_ip
  else
    get_pub_ip
  fi
  sleep 5&
  wait $!
done
