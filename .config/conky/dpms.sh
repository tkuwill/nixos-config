#!/bin/sh

xset -q | grep 'DPMS is' | awk '{print $1,$3}'
