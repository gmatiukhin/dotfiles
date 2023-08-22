#!/usr/bin/env bash
# Current Theme
theme="$HOME/.config/rofi/powermenu/theme.rasi"

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')" host=$(hostname)

# Options
shutdown=''
reboot=''
lock=''
suspend=''
logout=''

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$logout\n$suspend\n$lock\n$reboot\n$shutdown" |
    rofi -dmenu \
      -p "Uptime: ${uptime}" \
      -select $lock \
      -theme ${theme}
}

# Confirmation CMD
confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
    -theme-str 'mainbox {children: [ message, listview ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element {padding: 3px;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you Sure?' \
    -theme ${theme}
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
$shutdown)
  systemctl poweroff
  ;;
$reboot)
  systemctl reboot
  ;;
$lock)
  $HOME/.config/scripts/lock.sh
  ;;
$suspend)
  systemctl suspend
  ;;
$logout)
  i3-msg exit
  ;;
esac
