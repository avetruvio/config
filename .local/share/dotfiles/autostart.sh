#!/bin/bash

## Adding autostart functionality in i3-gaps wm 
## Finds any "Exec" lines in any xdg-like *.desktop files or symlinks
## in ~/.config/autostart, and runs the value of those lines. 

grep -h Exec ~/.config/autostart/* | while read -r line ; do
	${line:5} &
done
