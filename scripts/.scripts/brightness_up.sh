#! /usr/bin/env bash

BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/brightness)

if [[ $BRIGHTNESS -lt 100 ]]; then
   sudo echo $(echo $BRIGHTNESS+10 | bc) > /sys/class/backlight/intel_backlight/brightness
fi
