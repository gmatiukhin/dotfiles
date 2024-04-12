#!/usr/bin/env bash


function get_workspaces {
  echo "$(hyprctl workspaces -j | jq -c '[. | sort_by(.id) | .[] | .name]')"
}

# call once at startup to load workspaces with default open windows
eww update workspaces=$(get_workspaces)

function handle {
  command=$(echo $1 | awk -F'>>' '{print $1}')
  value=$(echo $1 | awk -F'>>' '{print $2}')

  if [[ $command == "workspace" ]]; then
    # set active workspace
    eww update active-workspace=$value
    # update open workspaces
    eww update workspaces=$(get_workspaces)
  fi
}

socat - "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" \
  | while read -r line; do handle "$line"; done
