#┏━━┓┃┃┃┃┃┃┃┃┓┃┃┓┃┃┃┃┃┓┃┃┏┓┃┃┃┃━━━┓┃┃┃┃┃┃┏┓┃┃┃┃┃┃┓┃
#┃┏┓┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┛┗┓┃┃┃┏━┓┃┃┃┃┃┃┃┛┗┓┃┃┃┃┃┃┃
#┃┗┛┗┓━━┓┃━━┓┃┏┓┃┃┓━━┓┗━┓┓┏┛┃┃┃┃┃┗┛━━┓━┓┃┓┏┛━┓━━┓┃┃
#┃┏━┓┃┃┓┃┃┏━┛┗┛┛┃┃┫┏┓┃┏┓┃┃┃┃┃┃┃┃┃┏┓┏┓┃┏┓┓┃┃┃┏┛┏┓┃┃┃
#┃┗━┛┃┗┛┗┓┗━┓┏┓┓┗┓┃┗┛┃┃┃┃┃┗┓┃┃┃┗━┛┃┗┛┃┃┃┃┃┗┓┃┃┗┛┃┗┓
#┗━━━┛━━━┛━━┛┛┗┛━┛┛━┓┃┛┗┛┗━┛┃┃┃━━━┛━━┛┛┗┛┗━┛┛┃━━┛━┛
#┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃━┛┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃
#┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃━━┛┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃


#!/bin/sh
# backlight up icon is from <a href="https://www.flaticon.com/free-icons/ui" title="ui icons">Ui icons created by Marz Gallery - Flaticon</a>.
# backlight down icon is from <a href="https://www.flaticon.com/free-icons/ui" title="ui icons">Ui icons created by Marz Gallery - Flaticon</a>.
# Credit from https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a & https://wiki.archlinux.org/title/Dunst  .

# You can call this script like this:
# $./screenlight.sh up
# $./screenlight.sh down

function get_brightness {
    light -G
}


function send_notification {
    brightness=`get_brightness`
    # Send the notification
     dunstify -a "changeVolume" -i /home/will/Pictures/sysicon/brightness-up.png -t 8000 -r 2593 -u normal -h int:value:"$brightness" "Brightness: ${brightness}%"
}

function send_notification1 {
    brightness=`get_brightness`
    # Send the notification
     dunstify -a "changeVolume" -i /home/will/Pictures/sysicon/brightness-down.png -t 8000 -r 2593 -u normal -h int:value:"$brightness" "Brightness: ${brightness}%"
}
case $1 in
    up)
	# Set the brightness on 
	
	# Up the brightness (+ 2%)
	light -A 2
	send_notification
	;;
    down)
	light -U 2
	send_notification1
	;;
esac
