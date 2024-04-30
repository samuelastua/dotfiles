
setxkbmap -option caps:escape
xss-lock --ignore-sleep -- xscreensaver-command -lock &
xscreensaver --no-splash &

picom -b &
dunst &
stheme

exec i3
