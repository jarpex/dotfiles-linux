#!/bin/sh

player_status=$(playerctl status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    if [ -z $(playerctl metadata artist) ]
    then	
    	echo " $(playerctl metadata title)"
    else
	    echo " $(playerctl metadata artist) — $(playerctl metadata title)"
    fi
elif [ "$player_status" = "Paused" ]; then
    if [ -z $(playerctl metadata artist) ]
    then	
    	echo " $(playerctl metadata title)"
    else
	    echo " $(playerctl metadata artist) — $(playerctl metadata title)"
    fi
fi
