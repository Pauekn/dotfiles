alias mplay='mplayer -fs -msgcolor -msgmodule -nomouseinput -nolirc'
alias countfiles='ls -1 | wc -l'
alias hdmi='xrandr --output HDMI2 --mode 1360x768 --above eDP1 && xrandr --output eDP1 --primary'

# Sound control

## Mute
alias volmute='amixer -D pulse sset Master 0%'

## Max volume
alias volmax='amixer -D pulse sset Master 100%'

## Increase volume
alias volinc='amixer -D pulse sset Master 5%+'

## Decrease volume
alias voldec='amixer -D pulse sset Master 5%-'

## Random crap
alias touchpad_disable='xinput --disable "SynPS/2 Synaptics TouchPad"' 
alias touchpad_enable='xinput --enable "SynPS/2 Synaptics TouchPad"'
alias i3lock='i3lock --color 000000 --ignore-empty-password --no-unlock-indicator --nofork'

alias s="sudo"
alias ic="ifconfig"

alias anihilist='pushd . && cd ~/bin/anihilist && python3 anihilist.py'
# Navigation
alias .="cd -"
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

# Apt-get
alias ai="sudo apt-get install"
alias ac="sudo apt-cache search"
alias au="sudo apt-get update"
alias ag="sudo apt-get upgrade"

alias re="| grep -i"

# System info
alias memino="free -m -l -t"

## Get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10="ps auxf | sort -nr -k 3 | head -10"

## CPU info
alias cpuinfo="lscpu"

alias df="df -H"
alias du="du -ch"

alias px="ps aux | grep"

alias fhere="find . -name"

alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
