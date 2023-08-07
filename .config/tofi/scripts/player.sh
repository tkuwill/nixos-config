#!/bin/sh
# Description: a menu run by tofi for controling media.

function now_play {
    playerctl metadata --format "{{ title }} 
{{ artist }} - {{ album }}"
}

function urls {
    cliphist list | sed '1 q' | awk '{print $2}'
}

function burls {
    cliphist list | sed '1 q' | awk '{print $2}'
}

if (ps -a | grep tofi >/dev/null); then
  killall -q tofi
else
  case $(printf "%s\n" "Cancel" "Now playing" "Open with mpv Yt" "Yt live" "Open with mpv BiliBili" "Play-pause" "Next" "Prev" | tofi -c ~/.config/tofi/soy-milk) in
  "Cancel")
    exit 0
    ;;
  "Now playing")
        dunstify -a "changeVolume" -i /home/will/Pictures/sysicon/music.png -t 5000 "$(now_play)"
    ;;
  "Open with mpv Yt")
	mpv $(urls)
    ;;
  "Yt live")
	mpv --cache=no $(urls)
    ;;
  "Open with mpv BiliBili")
	mpv --referrer="https://www.bilibili.com" $(burls)
    ;;
  "Play-pause")
	playerctl play-pause
    ;;
  "Next")
	playerctl next
    ;;
  "Prev")
	playerctl previous
    ;;
  esac
fi
