#!/bin/sh

## Build out the i3 config
##
## i3 does not support if statements in the config
## Thus, sharing this configuration accross installations becomes hard with host customizations
## So, let's build the config on each startup

## Rewrite the config and enter the main config

cat $HOME/.i3/base.part > $HOME/.i3/config

if [ $(hostname) = kurisu ] ; then
	cat $HOME/.i3/kurisu.part >> $HOME/.i3/config
elif [ $(hostname) = salieri ] ; then
	cat $HOME/.i3/salieri.part >> $HOME/.i3/config
	cat $HOME/.i3/generic.part >> $HOME/.i3/config
else
	cat $HOME/.i3/generic.part >> $HOME/.i3/config
fi

## Check for directories referenced in the config. 
## If they don't exist, create them
if [ ! -d ~/Pictures/screencaps ]; then
	mkdir ~/Pictures/screencaps
fi




## Check for Incompatabilities or missing bits. 
# Programs: feh, compton, xscreensaver, pactl, playerctl, urxvt, imagemagick
if [ ! -f /usr/bin/feh ]; then
	echo "exec \"i3-nagbar -m 'Program \\\"feh\\\" is not installed. Background image will not work' -t warning -b 'Install' 'i3-sensible-terminal -e sudo apt install feh'\"" >> config.test
elif [ ! -f /usr/bin/compton ]; then
	echo "exec \"i3-nagbar -m 'Program \\\"compton\\\" is not installed. Window Transparency will not work' -t warningi -b 'Install' 'i3-sensible-terminal -e sudo apt install compton'\"" >> config.test
elif [ ! -f /usr/bin/xscreensaver ]; then
	echo "exec \"i3-nagbar -m 'Program \\\"xscreensaver\\\" is not installed. Screensaver / Locking will not work' -t warning -b 'Install' 'i3-sensible-terminal -e sudo apt install xscreensaver xscreensaver-data xscreensaver-data-extra'\"" >> config.test
elif [ ! -f /usr/bin/pactl ]; then
	echo "exec \"i3-nagbar -m 'Program \\\"pactl\\\" is not installed. Audio will not work'-t warning -b 'Install' 'i3-sensible-terminal -e sudo apt install pulseaudio-utils\"" >> config.test
elif [ ! -f /usr/bin/urxvt ]; then
	echo "exec \"i3-nagbar -m 'Program \\\"urxvt\\\" is not installed. Prefered Terminal will not work' -t warning -b 'Install' 'i3-sensible-terminal -e sudo apt install rxvt-unicode'\"" >> config.test
elif [ ! -f /usr/bin/import ]; then
	echo "exec \"i3-nagbar -m 'Program \\\"imagemagick\\\" is not installed. Screen print will not work' -t warning -b 'Install' 'i3-sensible-terminal -e sudo apt install imagemagick'\"" >> config.test
elif [ ! -f /usr/bin/playerctl ]; then
	echo "exec \"i3-nagbar -m 'Program \\\"playerctl\\\" is not installed. Media Keys will not work' -t warning -b 'View Releases' 'xdg-open https://github.com/acrisci/playerctl/releases'\"" >> config.test
fi

## Add dependancy for xclip for copying screencaps to clipboard automatically. 
