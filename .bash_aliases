alias mplay='mplayer -fs -msgcolor -msgmodule -nomouseinput -nolirc'
alias mpv='mpv --osc=no'
alias countfiles='ls -1 | wc -l'
alias hdmi='xrandr --output HDMI2 --mode 1360x768 --above eDP1 && xrandr --output eDP1 --primary'
alias fuck='sudo $(fc -ln -1)'
alias lsusers="passwd.sh | grep -v -e '/false' -e '/nologin'"

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

alias astudio="/home/pauekn/bin/android-studio/bin/studio.sh &"

## Random alias. Will be deleted in a few weeks
alias bachelor='pushd && sudo mv ~/Downloads/sky_drone.rar /var/www/html/ ; sudo rm -R /var/www/html/sky_drone ; cd /var/www/html/ && sudo unrar e /var/www/html/sky_drone.rar && popd'
alias simon='mysql -u root -h 109.189.87.141'
alias cdskydrone='cd /var/www/html/sky_drone/src/skydrone/skydroneBundle/'
alias cdhtml='cd /var/www/html/'
alias cdtwig='cd /var/www/html/sky_drone/src/skydrone/skydroneBundle/Resources/views/Default'
alias cdcontroller='cd /var/www/html/sky_drone/src/skydrone/skydroneBundle/Controller'
