#!/bin/sh
# Description: show all notification histories stored by dunst. Only can show <= 20 notifications.

dunstify -a "center" -i /home/will/Pictures/sysicon/chat.png -t 8000 "Notification histories: $(dunstctl count history)" && sleep 2s &&	for i in {1..20}; do dunstctl history-pop; done
