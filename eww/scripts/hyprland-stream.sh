#!/usr/bin/env bash


function get_workspaces {
  echo "$(hyprctl workspaces -j | jq -c '[. | sort_by(.id) | .[] | .name]')"
}

# call once at startup to load workspaces with default open windows
eww update workspaces=$(get_workspaces)

function handle {
  echo $1
  # %% prevents splitting in a wrong place if >> is in the window title
  # https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion
  command=${1%%>>*}
  value=${1#*>>}

  case $command in

  "workspace")
    # set active workspace
    eww update active-workspace=$value
    # update open workspaces
    eww update workspaces=$(get_workspaces)
    ;;
  "activelayout")
    eww update kb-layout="${value#*,}"
    ;;
  "movewindow")
    eww update workspaces=$(get_workspaces)
    ;;
  esac
}

socat - "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" \
  | while read -r line; do handle "$line"; done
