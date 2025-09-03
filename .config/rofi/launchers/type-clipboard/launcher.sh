#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10
## style-11    style-12    style-13    style-14    style-15

dir="$HOME/.config/rofi/launchers/type-clipboard"
theme='style-3'

## Run

# cliphist list | rofi -dmenu -p "Clipboard history" -theme ${dir}/${theme}.rasi | cliphist decode | wl-copy

selected=$(cliphist list | rofi -dmenu -p "Clipboard history" -theme ${dir}/${theme}.rasi)

if [ -n "$selected" ]; then
    text=$(cliphist decode <<< "$selected")
    printf %s "$text" | wl-copy
    sleep 0.1
    wtype -- "$text"

    # Make a safe one-line snippet (truncate + strip newlines)
    snippet=$(echo "$text" | tr -d '\n' | head -c 30)
    [ ${#text} -gt 30 ] && snippet="$snippet…"

    notify-send "Clipboard updated" "'$snippet'" --app-name="Clipboard"
fi

