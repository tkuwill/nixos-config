#!/bin/sh
# A script for starting browsers.



function browser {
    options="Cancel\nChromium\nFirefox\nbilibili"
    selected=$(echo -e $options | dmenu -i -p "Which browser do you want to use ?")
    if [[ $selected = "Chromium" ]]; then 
        chromium   
    elif [[ $selected = "Firefox" ]]; then 
	firefox
    elif [[ $selected = "bilibili" ]]; then 
        firefox --new-window https://www.bilibili.com/
    elif [[ $selected = "Cancel" ]]; then 
        return
    fi
}

browser
