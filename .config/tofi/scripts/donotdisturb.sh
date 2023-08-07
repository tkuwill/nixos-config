#!/bin/sh
# Description: a menu run by tofi which can show calendar in xterm.

if (ps -a | grep tofi >/dev/null); then
  killall -q tofi
else
  case $(printf "%s\n" "Cancel" "Notification center" "Close all notifications" "Clean all notifications" "Do not disturb" "Normal" | tofi -c ~/.config/tofi/soy-milk) in
  "Cancel")
    exit 0
    ;;
  "Notification center")
	/home/will/shellscripts/notificationcenter.sh
    ;;
  "Close all notifications")
	dunstctl close-all
    ;;
  "Clean all notifications")
	dunstctl history-clear && dunstify -a "changeVolume" -i /home/will/Pictures/sysicon/chat.png -t 8000 "Notifications history purged !"  
    ;;
  "Do not disturb")
        notify-send -i /home/will/Pictures/sysicon/bell.png -u critical -t 3000 "Do Not Disturb is now ON." && sleep 1s && dunstctl set-paused true
    ;;
  "Normal")
        dunstctl set-paused false && notify-send -i /home/will/Pictures/sysicon/bell-ring.png -u critical -t 8000 "Do Not Disturb is now OFF."  
    ;;
  esac
fi
