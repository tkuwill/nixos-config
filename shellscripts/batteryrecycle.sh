#!/bin/sh

date >> ~/shellscripts/log/batteryRecycle.log && cat /sys/class/power_supply/BAT0/cycle_count | awk '{print "Cycle count: " $1}' >> ~/shellscripts/log/batteryRecycle.log && acpi --everything | sed '3,16 d' | sed '1 d' >> ~/shellscripts/log/batteryRecycle.log

bat ~/shellscripts/log/batteryRecycle.log
