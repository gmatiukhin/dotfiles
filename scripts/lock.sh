#!/usr/bin/env bash

radius=25
ring=5
inset=10

# offsets from the bottom left corner, with (0, 0) at screen's top left
box_offset_x=30
box_offset_y=30

# offsets relative to the box
shadow_offset_x=0
shadow_offset_y=0

box_width=300 # find a way to calculate this
box_height=$(($inset * 2 + $radius * 2 + $ring + 2))

box_color=00000066
box_shadow=00000066

locktext="Type your password..."
font="FiraCodeNerdFontMono-Bold"
font_size=36
font_size_md=16

ringcolor=1a1b26
insidecolor=00000000
separatorcolor=000000

ringvercolor=7aa2f7
insidevercolor=00000000

ringwrongcolor=f7768e
insidewrongcolor=00000000

timecolor=bb9af7
time_format="%H:%M:%S"

greetercolor=c0caf5
layoutcolor=c0caf5

keyhlcolor=9ece6a
bshlcolor=f7768e

verifcolor=ffffff

wrongcolor=d23c3d

modifcolor=d23c3d
bgcolor=00000000

boxes=" "
shadows=" "

screen_resolution=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
for res in $screen_resolution; do
  screen_resolution_array=(${res//[x+]/ })
  # bottom left corner coordinates
  x=$((${screen_resolution_array[2]} + box_offset_x))
  y=$((${screen_resolution_array[1]} - box_offset_y))
  boxes+="rectangle $x,$y $((x + box_width)),$((y - box_height)) "
  sx=$((x + shadow_offset_x))
  sy=$((y + shadow_offset_y))
  shadows+="rectangle $sx,$sy $((sx + box_width)),$((sy - box_height)) "
done

if [ $(xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p') = on ]; then
  xdotool key Caps_Lock
fi

kb=$(xkb-switch)
xkb-switch -s us
setxkbmap -option caps:none
dunst_notif_status=$(dunstctl is-paused)
dunstctl set-paused true

convert $HOME/.config/images/cory-billett-luthadel-bt2.jpg \
  -draw "fill #$box_shadow $shadows" \
  -draw "fill #$box_color $boxes" RGB:- |
  i3lock \
    --raw "$(echo $screen_resolution | awk -F '+' '{print $1}'):rgb" --image /dev/stdin \
    --nofork \
    --ignore-empty-password \
    --color "$bgcolor" \
    --screen "$display_on" \
    --ind-pos="$box_offset_x+$box_width-r-$inset:h-$box_offset_y-$box_height/2" \
    --radius=$radius \
    --ring-width=$ring \
    --inside-color="$insidecolor" \
    --ring-color="$ringcolor" \
    --separator-color=$separatorcolor \
    --insidever-color="$insidevercolor" \
    --insidewrong-color="$insidewrongcolor" \
    --ringver-color="$ringvercolor" \
    --ringwrong-color="$ringwrongcolor" \
    --line-uses-inside \
    --keyhl-color="$keyhlcolor" \
    --bshl-color="$bshlcolor" \
    --clock --force-clock \
    --time-pos="$box_offset_x+$inset:h-$box_offset_y-$box_height+0.75*$font_size+$inset" \
    --time-align 1 \
    --time-str="$time_format" \
    --time-color="$timecolor" \
    --time-font="$font" \
    --time-size="$font_size" \
    --greeter-pos="$box_offset_x+$inset:h-$box_offset_y-$inset" \
    --greeter-align 1 \
    --greeter-text "$locktext" \
    --greeter-color="$greetercolor" \
    --greeter-font="$font" \
    --greeter-size="$font_size_md" \
    --verif-text="" \
    --wrong-text="" \
    --no-modkey-text \
    --noinput-text="" \
    --pass-media-keys \
    --pass-screen-keys \
    --pass-volume-keys \
    --pass-power-keys

dunstctl set-paused $dunst_notif_status
setxkbmap -option
xkb-switch -s $kb
