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
# fi
#     PATH="$HOME/.local/bin:$PATH"

# export XDG_CONFIG_HOME=$HOME/.config

# Little function for rendering .md files using a trick
# Requires installation of pandoc and w3m
# Uses pandoc to transpose markdown into html, uses w3m to render said html piped as stdin
rmd () {
	pandoc $1 | w3m -T text/html
}

# Android SDK Platform Tools
if [ -d "$HOME/.local/share/platform-tools" ] ; then
	PATH="$HOME/.local/share/platform-tools:$PATH"
fi