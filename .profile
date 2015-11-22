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
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Set black solid background colour 
#xsetroot -solid "#000000"

# Disable touchpad
## My touchpad is not working properly, so having it enabled causes a lot of trouble
xinput --disable "SynPS/2 Synaptics TouchPad"

# Turns off screensaver 
xset s off

# Remapping keys

if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

 # Caps --> Ctrl
setxkbmap -option caps:ctrl_modifier
 # Ctrl_L --> Esc
xmodmap -e "keycode 37 = Escape NoSymbol Escape"
 # Escape --> Caps_Lock
xmodmap -e "keycode 9 = Caps_Lock NoSymbol Caps_Lock"

# Sets the wallpaper
feh --bg-scale ~/.wallpaper/wallpaper_world_of_warships_02_1360x768.jpg
