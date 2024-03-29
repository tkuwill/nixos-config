#                   __                         __                   
#                  |  \                       |  \                  
#  _______  ______ | ▓▓ ______  _______   ____| ▓▓ ______   ______  
# /       \|      \| ▓▓/      \|       \ /      ▓▓|      \ /      \ 
#|  ▓▓▓▓▓▓▓ \▓▓▓▓▓▓\ ▓▓  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\  ▓▓▓▓▓▓▓ \▓▓▓▓▓▓\  ▓▓▓▓▓▓\
#| ▓▓      /      ▓▓ ▓▓ ▓▓    ▓▓ ▓▓  | ▓▓ ▓▓  | ▓▓/      ▓▓ ▓▓   \▓▓
#| ▓▓_____|  ▓▓▓▓▓▓▓ ▓▓ ▓▓▓▓▓▓▓▓ ▓▓  | ▓▓ ▓▓__| ▓▓  ▓▓▓▓▓▓▓ ▓▓      
# \▓▓     \\▓▓    ▓▓ ▓▓\▓▓     \ ▓▓  | ▓▓\▓▓    ▓▓\▓▓    ▓▓ ▓▓      
#  \▓▓▓▓▓▓▓ \▓▓▓▓▓▓▓\▓▓ \▓▓▓▓▓▓▓\▓▓   \▓▓ \▓▓▓▓▓▓▓ \▓▓▓▓▓▓▓\▓▓      
                                                                   
                                                                   
                                                                   
#!/bin/sh

function calendar {
    options="Cancel\nthis-month\nthis-year\nnext-twelve-months"
    selected=$(echo -e $options | dmenu -i -p "Calendar")
    if [[ $selected = "this-month" ]]; then 
        xterm -T 'Calendar of this month' -e zsh -c 'cal; zsh'
    elif [[ $selected = "this-year" ]]; then 
        xterm -T 'Calendar of this year' -e zsh -c 'cal -y; zsh'
    elif [[ $selected = "next-twelve-months" ]]; then 
        xterm -T 'Calendar of next 12 months' -e zsh -c 'cal -Y; zsh'
    elif [[ $selected = "Cancel" ]]; then 
        return
    fi
}

calendar
