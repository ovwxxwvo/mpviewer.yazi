#!/usr/bin/env bash


preview_file="${1}"
  x="$2"
  y="$3"
  w="$4"
  h="$5"

tmux_pid=''
wins_pid=''
  win_x=''
  win_y=''
  app_w=''
  app_h=''
  med_w=''
  med_h=''

server='mpv'
  pane_tty=''
  server_dirt=''
  server_file=''
  window_title=''
  server_count=''

get_file() {
  pane_tty=$( tty |sed 's/dev//g;s/\///g' )
  server_dirt="/tmp/${server}-${pane_tty}"
  server_file="${server_dirt}/ipc.sock"
  window_title="${server}-${pane_tty}"

  server_count=$( ps -f |grep -v "grep" |grep -c "$server_file" )
  [ $server_count -eq 0 ] && exit
  # echo -en $pane_tty
  # echo $server_dirt
  # echo $server_file
  # echo $window_title
  # echo $server_count
  }

get_rect() {
  tmux_pid=$(tmux display-message -p '#{client_pid}')
  # wins_pid=$(ps -ef |grep -v "grep" |grep "$tmux_pid" |awk '{print $3}' )
  wins_pid=$( swaymsg -t get_tree |jq -j '.. | select(.type?) | select(.focused) | .pid' )
  scale=$(swaymsg -t get_outputs |jq -r '.[] | select(.focused) | .scale')
  win_x=$(swaymsg -t get_tree |jq -j '.. | select(.type?) | select(.focused).rect | .x')
  win_y=$(swaymsg -t get_tree |jq -j '.. | select(.type?) | select(.focused).rect | .y')
  x=$(echo "$win_x+$x/$scale" |bc)
  y=$(echo "$win_y+$y/$scale" |bc)

  app_w=$(echo "$w" |bc)
  app_h=$(echo "$h" |bc)
  med_w=$( \
    exiftool "$preview_file" \
    |grep -Ei '^[[:space:]]*Image Width' \
    |grep -Eo '[0-9]*' \
    )
  med_h=$( \
    exiftool "$preview_file" \
    |grep -Ei '^[[:space:]]*Image Height' \
    |grep -Eo '[0-9]*' \
    )

  [ "$med_w" == '' ] || [ "$med_h" == '' ] && return
  if [ $med_w -le $app_w ] && [ $med_h -le $app_h ] ;then
    w=$med_w
    h=$med_h
    fi
  # echo $tmux_pid
  # echo $wins_pid
  # echo $app_w $app_h $med_w $med_h
  # echo $x $y $w $h
  }

set_mpv() {
  tmux set -g @sway_wins_pid_mpv "$wins_pid"
  tmux set -g @tmux_pane_tty_mpv "$pane_tty"
  # echo '{ "command": [ "", ""] }' |socat - "$server_file"
  file=$(echo '{"command":[ "get_property","path" ]}' |socat - "$server_file" |awk -F"[:,]+" '{print $2}' |sed 's/^\"//;s/\"$//')
  [ "$file" == "$preview_file" ] && exit

  echo '{"command":[ "loadfile","'"$preview_file"'" ]}' |socat - "$server_file"
  echo '{"command":[ "set_property","autofit","'"$w"'x'"$h"'" ]}' |socat - "$server_file"
  echo '{"command":[ "set_property","pause",false]}' |socat - "$server_file"
  swaymsg [title="$window_title"] move absolute position $x $y
  swaymsg [title="$window_title"] move workspace current
  # swaymsg [pid="$wins_pid"] focus
  }


get_rect
get_file
set_mpv


