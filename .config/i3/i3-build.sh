#!/bin/sh

## Build out the i3 config
##
## i3 does not support if statements in the config
## Thus, sharing this configuration accross installations becomes hard with host customizations
## So, let's build the config on each startup

## Rewrite the config and enter the main config

cat "$HOME/.config/i3/base.part" > "$HOME/.config/i3/config"
cat "$HOME/.config/i3/generic.part" >> "$HOME/.config/i3/config"

## Check for directories referenced in the config. 
## If they don't exist, create them
if [ -d ~/Pictures ]; then
	if [ ! -d ~/Pictures/screencaps ]; then
		mkdir ~/Pictures/screencaps
	fi
fi




## Check for Incompatabilities or missing bits.
# Programs: feh, compton, light-locker, pactl, urxvt, imagemagick (import), playerctl, xclip
check_dep() {
	bin="$1"
	msg="$2"
	btn_label="$3"
	btn_cmd="$4"
	if ! command -v "$bin" >/dev/null 2>&1; then
		echo "exec \"i3-nagbar -m '$msg' -t warning -b '$btn_label' '$btn_cmd'\"" >> "$HOME/.config/i3/config"
	fi
}

check_dep feh          'Program \"feh\" is not installed. Background image will not work'          'Install' 'i3-sensible-terminal -e sudo apt install feh'
check_dep compton      'Program \"compton\" is not installed. Window Transparency will not work'   'Install' 'i3-sensible-terminal -e sudo apt install compton'
check_dep light-locker 'Program \"light-locker\" is not installed. Screen locking will not work'   'Install' 'i3-sensible-terminal -e sudo apt install light-locker'
check_dep pactl        'Program \"pactl\" is not installed. Audio will not work'                   'Install' 'i3-sensible-terminal -e sudo apt install pulseaudio-utils'
check_dep urxvt        'Program \"urxvt\" is not installed. Preferred Terminal will not work'      'Install' 'i3-sensible-terminal -e sudo apt install rxvt-unicode'
check_dep import       'Program \"imagemagick\" is not installed. Screen print will not work'      'Install' 'i3-sensible-terminal -e sudo apt install imagemagick'
check_dep xclip        'Program \"xclip\" is not installed. Screenshot clipboard copy will not work' 'Install' 'i3-sensible-terminal -e sudo apt install xclip'
check_dep playerctl    'Program \"playerctl\" is not installed. Media Keys will not work'          'View Releases' 'xdg-open https://github.com/altdesktop/playerctl/releases'
