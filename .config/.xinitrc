unclutter &
xrdb -merge ~/.Xresources
fcitx5 -d
dunst &

# Here dwm is kept as default
session=${1:-dwm}

case $session in
    i3|i3wm           ) exec i3;;
    bsp|bspwm ) exec bspwm;;
    # No known session, try to run it as command
    *                 ) exec $1;;
esac

