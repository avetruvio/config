# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -z "$PS1" ]; then
	# Interactive Shell

	# Swap Caps Lock and Escape around
	/usr/bin/setxkbmap -option "caps:swapescape"
	# Wishlist: Add feature that escape, while pressed alone, behaves as escape, but in combination with other keys, behaves as the control key. 


	# If kurisu, the awesome main triple monitor machine~ 
	if [ $HOSTNAME == "kurisu" ]; then
		# Put monitors in the right order
		xrandr --output DP-1 --left-of DP-5 --output DP-3 --right-of DP-5

		# Export the correct Pulse Audio profile
		export PULSE_SINK=alsa_output.usb-BEHRINGER_UMC204HD_192k-00.analog-surround-40

	fi

	if [ $HOSTNAME == "salieri" ]; then
		# Export the correct Pulse Audio profile
		export PULSE_SINK=alsa_output.pci-0000_00_1b.0.analog-stereo
		export PULSE_SOURCE=alsa_input.pci-0000_00_1b.0.analog-stereo
	fi
fi

# Little function for rendering .md files using a trick
# Requires installation of pandoc and w3m
# Uses pandoc to transpose markdown into html, uses w3m to render said html piped as stdin
rmd () {
	pandoc $1 | w3m -T text/html
}


if [ -f ~/.i3/i3-build.sh ]; then
	~/.i3/i3-build.sh
fi


# Android SDK Platform Tools
if [ -d "$HOME/.local/share/platform-tools" ] ; then
	PATH="$HOME/.local/share/platform-tools:$PATH"
fi
