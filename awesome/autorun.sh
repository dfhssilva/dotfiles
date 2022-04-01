#!/usr/bin/env bash

function run {
	if ! pgrep -f $1; then
		$@ &
	fi
}

run xrandr --output HDMI-1-0 --auto --right-of eDP1
# run picom -b
