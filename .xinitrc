
<<<<<<< HEAD
setxkbmap -option caps:escape
xss-lock --ignore-sleep -- xscreensaver-command -lock &
xscreensaver --no-splash &

picom -b &
stheme

exec i3
=======

# Increase key speed via a rate change
 (change of behavior for fast hjkl movement)
xset r rate 300 50

# some key remappings
setxkbmap -option caps:escape

# outoput config
xrandr --output DP-3 --mode 1366x768 --rate 60 --left-of DP-0
xrandr --output DP-0 --primary --mode 1920x1080 --rate 144  
xrandr --output HDMI-0 --mode 1366x768  --right-of DP-0


# Handle systemd signals (e.g loginctl lock-session)
# xss-lock --transfer-sleep-lock -- lockscreen &
xss-lock --ignore-sleep -- xscreensaver-command -lock



# Set opacity, blur, animations (and other UI enhancements)
picom -b

# Set wallpaper/theme dynamically
stheme &

# Start CopyQ clipboard manager only when X server starts (can't if not cause off Qt)
# and dont't wan't to start X as systemd daemon
copyq &

# Start notification daemon
dunst &

xscreensaver --no-splash &

# i3 wm activation
exec dbus-run-session i3

>>>>>>> d7275e6 (sshhh)
