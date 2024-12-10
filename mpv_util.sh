#!/usr/bin/env bash


func=$1
unit=$2
  server='mpv'
  pane_tty=''
  server_dirt=''
  server_file=''
  window_title=''
  server_count=''

get_file() {
  pane_tty=$( tty |sed 's/\///g;s/dev//g' )
  server_dirt="/tmp/${server}-${pane_tty}"
  server_file="${server_dirt}/ipc.sock"
  window_title="${server}-${pane_tty}"
  server_count=$( ps -f |grep -v "grep" |grep -c "$server_file" )
  [ $server_count -eq 0 ] && exit
  # echo $pane_tty
  # echo $server_dirt
  # echo $server_file
  # echo $window_title
  # echo $server_count
  }

set_mpv() {
  f=$func
  u=$unit
  if [ "$func" == 'enter' ] ;then
    echo '{ "command" : ["set_property","pause",true] }' |socat - "$server_file"
    swaymsg  [title="$window_title"] move scratchpad
  elif [ "$func" == 'seek' ] ;then
    echo '{"command":["seek","'"$u"'"]}' |socat - "$server_file"
  elif [ "$func" == 'zoom' ] ;then
    echo '{"command":["add","video-zoom","'"$u"'"]}' |socat - "$server_file"
  fi
  }

get_file
set_mpv


