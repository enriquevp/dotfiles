#! /usr/bin/env bash

BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/brightness)

if [[ $BRIGHTNESS -gt 10 ]]; then
    echo $BRIGHTNESS
   sudo echo $(echo $BRIGHTNESS-10 | bc) > /sys/class/backlight/intel_backlight/brightness
fi
