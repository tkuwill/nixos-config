#██████╗ ███████╗███╗   ███╗██╗███╗   ██╗██████╗ ███████╗██████╗ 
#██╔══██╗██╔════╝████╗ ████║██║████╗  ██║██╔══██╗██╔════╝██╔══██╗
#██████╔╝█████╗  ██╔████╔██║██║██╔██╗ ██║██║  ██║█████╗  ██████╔╝
#██╔══██╗██╔══╝  ██║╚██╔╝██║██║██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗
#██║  ██║███████╗██║ ╚═╝ ██║██║██║ ╚████║██████╔╝███████╗██║  ██║
#╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝

#!/bin/sh


echo "Input mins:"
read mins
echo "Input reminder messages:"
read msg
echo "Now time is "
date "+%T"
echo "Set a timer for ${mins} minute(s)."
sleep ${mins}m && notify-send -u critical -t 10000 ${msg}
mpv ~/Music/lovesong/大好きだよ｡.mp3 --start=100 --end=120 --keep-open=no --no-resume-playback --no-terminal --no-video
