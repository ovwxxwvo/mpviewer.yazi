#!/usr/bin/env bash


url="${1}"
ext="${url##*.}"

echo '==================== Media Info ===================='

case "$ext" in

jpg|png|gif|bmp|tif|tiff )
  exiftool "$url" \
    |sed \
    -e 's/  */ /g' \
    -e 's/^file name /00 | &/Ig' \
    -e 's/^mime type /03 | &/Ig' \
    -e 's/^image size /04 | &/Ig' \
    -e 's/^bits per /05 | &/Ig' \
    -e 's/^megapixels/06 | &/Ig' \
    -e 's/^make /07 | &/Ig' \
    -e 's/^camera model /08 | &/Ig' \
    |grep -E "^00 |^01 |^02 |^03 |^04 |^05 |^06 |^07 |^08 " \
    |sort -n |awk -F"[|:]" '{printf "%-20s:%-20s \n", $2,$3 }'
  # exit 0
  ;;

mp3|m4a|aac|ogg|wav|flac )
  exiftool "$url" \
    |sed \
    -e 's/  */ /g' \
    -e 's/^file name /00 | &/Ig' \
    -e 's/^mime type /03 | &/Ig' \
    -e 's/^channel mode /04 | &/Ig' \
    -e 's/^audio bitrate /05 | &/Ig' \
    -e 's/^sample rate /06 | &/Ig' \
    -e 's/^artist /07 | &/Ig' \
    -e 's/^title /08 | &/Ig' \
    |grep -E "^00 |^01 |^02 |^03 |^04 |^05 |^06 |^07 |^08 " \
    |sort -n |awk -F"[|:]" '{printf "%-20s:%-20s \n", $2,$3 }'
  # exit 0
  ;;

mp4|m4v|mkv|flv|avi|webm )
  exiftool "$url" \
    |sed \
    -e 's/  */ /g' \
    -e 's/^file name /00 | &/Ig' \
    -e 's/^mime type /03 | &/Ig' \
    -e 's/^image size /04 | &/Ig' \
    -e 's/^video frame /05 | &/Ig' \
    -e 's/^audio sample rate/06 | &/Ig' \
    -e 's/^video codec /07 | &/Ig' \
    -e 's/^audio codec /08 | &/Ig' \
    |grep -E "^00 |^01 |^02 |^03 |^04 |^05 |^06 |^07 |^08 " \
    |sort -n |awk -F"[|:]" '{printf "%-20s:%-20s \n", $2,$3 }'
  # exit 0
  ;;

esac


