# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# If not running interactively, do not do anything
# If you don't do this, your (graphical) login sessions will hang
#[[ $- != *i* ]] && return

# If we are not yet in a screen session
#if [[ $TERM != screen* ]]; then
  # Start tmux if there is no panicfile and tmux actually exists.
#  [ ! -f /tmp/panic -a -x /usr/bin/tmux ] && exec tmux
#fi



# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Function for Command Substitution in bash prompt to show current git branch
parse_git_branch(){
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[38;5;10m\]\u@\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;4m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\]$(parse_git_branch)\[\033[38;5;5m\] $ \[$(tput sgr0)\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

## ## # ## ##
## ALIASES ##
## ## # ## ##


# If not running interactively, do not do anything
## If you don't do this, your (graphical) login sessions will hang
#[[ $- != *i* ]] && return

# If we are not yet in a screen session
#if [[ $TERM != screen* ]]; then
  # Start tmux if there is no panicfile and tmux actually exists.
#  [ ! -f /tmp/panic -a -x /usr/bin/tmux ] && exec tmux
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -CF --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Custom colors for LS
# https://askubuntu.com/questions/466198/how-do-i-change-the-color-for-directories-with-ls-in-the-console
LS_COLORS=$LS_COLORS:'di=0;34:'; export LS_COLORS

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;33:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
# alias ls='ls -CF'
alias l='ls'

# If full vim installed, use that instead of vi
if [ -f /usr/bin/vim ]; then
    alias vi='vim'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Force 256color for tmux
alias tmux="tmux -2"


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.config/bash/aliases ]; then
    . ~/.config/bash/aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Run MOTD in tmux session (Since I like to auto-start it from my KiTTY config) 
if [[ -n "$TMUX" ]]; then
	if [ -f /run/motd.dynamic ]; then
	  cat /run/motd.dynamic
	fi
fi

function cd { 
	builtin cd "$@" && ls -F
}


set -o vi

## Environment Variables

## Termite terminfo
export TERMINFO="$HOME/.config/terminfo/"
