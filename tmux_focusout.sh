#!/usr/bin/env bash


server='mpv'
  pane_tty=''
  pane_tty_mpv=''
  pane_tty_now=''
  server_dirt=''
  server_file=''
  window_title=''
  server_count=''


get_file() {
  # wins_pid=$( tmux show -gv @sway_wins_pid_mpv )
  pane_tty=$( tmux show -gv @tmux_pane_tty_mpv )
  [ "$pane_tty" == '' ] && exit

  # wins_pid_mpv=$wins_pid
  # wins_pid_now=$( swaymsg -t get_tree |jq -j '.. | select(.type?) | select(.focused) | .pid' )
  #
  # pane_tty_mpv=$pane_tty
  # pane_tty_now=$( tmux display -p '#{pane_tty}' |sed 's/dev//g;s/\///g' )

  server_dirt="/tmp/${server}-${pane_tty}"
  server_file="${server_dirt}/ipc.sock"
  window_title="${server}-${pane_tty}"
  echo $pane_tty
  # echo $server_dirt
  # echo $server_file
  # echo $window_title
  # echo $server_count
  }

set_mpv() {
  swaymsg [title="$window_title"] move scratchpad
  }


# get_file
# stop_media
get_file   > /dev/null 2>&1
set_mpv > /dev/null 2>&1


