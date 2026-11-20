#!/bin/bash

## Adding autostart functionality in i3-gaps wm
## Finds the first "Exec=" line in the [Desktop Entry] section of any
## ~/.config/autostart/*.desktop files, strips desktop field codes, and launches it.

autostart_dir="${XDG_CONFIG_HOME:-$HOME/.config}/autostart"
shopt -s nullglob
for f in "$autostart_dir"/*.desktop; do
	cmd=$(awk '
		/^\[Desktop Entry\]/ { in_entry=1; next }
		/^\[/ { in_entry=0 }
		in_entry && /^Exec=/ {
			sub(/^Exec=/, "")
			gsub(/%[fFuUdDnNickvm]/, "")
			print
			exit
		}
	' "$f")
	if [ -n "$cmd" ]; then
		sh -c "$cmd" >/dev/null 2>&1 &
	fi
done
