#!/bin/sh
# Description: powermenu used by tofi

function ck {
    date "+%T"
}
if (ps -a | grep tofi >/dev/null); then
  killall -q tofi
else
  case $(printf "%s\n" "Cancel" "Lock" "Suspend" "Log Out" "Power Off" "Restart"  | tofi -c ~/.config/tofi/soy-milk) in
  "Cancel")
    exit 0
    ;;
  "Lock")
    swaylock
    ;;
  "Suspend")
        sleep 1s && systemctl suspend
    ;;
  "Log Out")
    if [[ "$DESKTOP_SESSION" == "hyprland" ]]; then
      hyprctl dispatch exit 1
    elif [[ "$DESKTOP_SESSION" == "sway" ]]; then
      swaymsg exit
    fi
    ;;
  "Power Off")
	notify-send -i /home/will/Pictures/sysicon/power.png -u critical -t 0 "Now time is $(ck) . 
ASUS 'll be shutdown in 1 min. Use 'shutdown -c' to cancel." && shutdown
    ;;
  "Restart")
        notify-send -i /home/will/Pictures/sysicon/restart.png -u critical -t 0 "Computer will be rebooted in 30 secs." && sleep 30s && reboot
    ;;
  esac
fi
