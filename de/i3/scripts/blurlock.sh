#!/bin/sh
scrot /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x5 /tmp/blurred.png
i3lock -i /tmp/blurred.png