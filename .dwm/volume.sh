# __     __          __                                      ______                      __                       __ 
#|  \   |  \        |  \                                    /      \                    |  \                     |  \
#| ▓▓   | ▓▓ ______ | ▓▓__    __ ______ ____   ______      |  ▓▓▓▓▓▓\ ______  _______  _| ▓▓_    ______   ______ | ▓▓
#| ▓▓   | ▓▓/      \| ▓▓  \  |  \      \    \ /      \     | ▓▓   \▓▓/      \|       \|   ▓▓ \  /      \ /      \| ▓▓
# \▓▓\ /  ▓▓  ▓▓▓▓▓▓\ ▓▓ ▓▓  | ▓▓ ▓▓▓▓▓▓\▓▓▓▓\  ▓▓▓▓▓▓\    | ▓▓     |  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\\▓▓▓▓▓▓ |  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\ ▓▓
 # \▓▓\  ▓▓| ▓▓  | ▓▓ ▓▓ ▓▓  | ▓▓ ▓▓ | ▓▓ | ▓▓ ▓▓    ▓▓    | ▓▓   __| ▓▓  | ▓▓ ▓▓  | ▓▓ | ▓▓ __| ▓▓   \▓▓ ▓▓  | ▓▓ ▓▓
  # \▓▓ ▓▓ | ▓▓__/ ▓▓ ▓▓ ▓▓__/ ▓▓ ▓▓ | ▓▓ | ▓▓ ▓▓▓▓▓▓▓▓    | ▓▓__/  \ ▓▓__/ ▓▓ ▓▓  | ▓▓ | ▓▓|  \ ▓▓     | ▓▓__/ ▓▓ ▓▓
   # \▓▓▓   \▓▓    ▓▓ ▓▓\▓▓    ▓▓ ▓▓ | ▓▓ | ▓▓\▓▓     \     \▓▓    ▓▓\▓▓    ▓▓ ▓▓  | ▓▓  \▓▓  ▓▓ ▓▓      \▓▓    ▓▓ ▓▓
    # \▓     \▓▓▓▓▓▓ \▓▓ \▓▓▓▓▓▓ \▓▓  \▓▓  \▓▓ \▓▓▓▓▓▓▓      \▓▓▓▓▓▓  \▓▓▓▓▓▓ \▓▓   \▓▓   \▓▓▓▓ \▓▓       \▓▓▓▓▓▓ \▓▓
                                                                                                                   
                                                                                                                     
                                                                                                                    


#!/bin/sh
# volume up icon is from <a href="https://www.flaticon.com/free-icons/volume-up" title="volume up icons">Volume up icons created by Freepik - Flaticon</a>.
# volume down icon is from "https://www.flaticon.com/free-icons/volume-down" title="volume down icons">Volume down icons created by Freepik - Flaticon
# volume mute icon is from <a href="https://www.flaticon.com/free-icons/ui" title="ui icons">Ui icons created by Icon Hubs - Flaticon</a>.
# Credit from https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a & https://wiki.archlinux.org/title/Dunst  .

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $(($volume / 2)) | sed 's/[0-9]//g')
    # Send the notification
     dunstify -a "changeVolume" -i /home/will/Pictures/sysicon/volume-up.png -t 8000 -r 2593 -u normal -h int:value:"$volume" "Volume: ${volume}%"
}

function send_notification1 {
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $(($volume / 2)) | sed 's/[0-9]//g')
    # Send the notification
     dunstify -a "changeVolume" -i /home/will/Pictures/sysicon/volume-down.png -t 8000 -r 2593 -u normal -h int:value:"$volume" "Volume: ${volume}%"
}

function sendmute {
     dunstify -a "changeVolume" -i /home/will/Pictures/sysicon/mute.png -t 8000 -r 2593 -u normal "Volume: Mute"
}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer set Master on > /dev/null
	# Up the volume (+ 2%)
	amixer set Master 2%+ > /dev/null
	send_notification
	;;
    down)
	amixer set Master on > /dev/null
	amixer set Master 2%- > /dev/null
	send_notification1
	;;
    mute)
    	# Toggle mute
	amixer set Master 1+ toggle > /dev/null
	if is_mute ; then
        sendmute
    else
        send_notification
	fi
	;;
esac
