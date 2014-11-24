# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
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

function get_touchpad_id() {
    echo $(xinput | grep -i touchpad | awk '{print $6}' | tr -cd [:digit:])

}

function touchpad_enable() {
    enabled="$1"
echo $enabled
    $touchpad_id=$(get_touchpad_id)
#echo $touchpad_id
    $(xinput set-prop $touchpad_id "Device Enabled" $enabled)
}


# PulseAudio
pa-list() { pacmd list-sinks | awk '/index/ || /name:/' ;}
pa-set() { 
    # list all apps in playback tab (ex: cmus, mplayer, vlc)
    inputs=($(pacmd list-sink-inputs | awk '/index/ {print $2}')) 
    # set the default output device
    pacmd set-default-sink $1 &> /dev/null
    # apply the changes to all running apps to use the new output device
    for i in ${inputs[*]}; do pacmd move-sink-input $i $1 &> /dev/null; done
}
pa-playbacklist() { 
    # list individual apps
    echo "==============="
    echo "Running Apps"
    pacmd list-sink-inputs | awk '/index/ || /application.name /'

    # list all sound device
    echo "==============="
    echo "Sound Devices"
    pacmd list-sinks | awk '/index/ || /name:/'
}
pa-playbackset() { 
    # set the default output device
    pacmd set-default-sink "$2" &> /dev/null
    # apply changes to one running app to use the new output device
    pacmd move-sink-input "$1" "$2" &> /dev/null
}


#!/bin/bash

anime-crunchyroll() { # {{{
test
        keyword="$(echo "http://www.crunchyroll.com/search?from=videos&q=$@" | sed 's/ /\+/g')"
        # keyword="$(echo "http://www.xvideos.com/?k=$@" | sed 's/ /\+/g')"
	pagenum=5
	pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword&p=$num"; done )
# http://www.crunchyroll.com/akame-ga-kill/episode-21-662273
	videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
	| awk '/crunchyroll\.com\/video/ {print $2}' | awk '!x[$0]++' ; done)

	echo $videourl | sed 's/\ /\n/g' | awk '!x[$0]++' > /tmp/porn.org
	emacs --no-window-system /tmp/porn.org
#	rm /tmp/porn.org
}

#-------- Internet Videos - Porn {{{
#------------------------------------------------------
# youtube-dl
fap-uporn() {
	grepmatch=$(echo "$@" | sed 's/ /.*/g')
        keyword="$(echo "http://www.youporn.com/search?query=$@&type=straight" | sed 's/ /\+/g')"
	pagenum=3
	pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword&page=$num"; done )
	videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
	| awk '/watch/ {print $2}' | cut -d\/ -f1-6 | grep -iE $grepmatch | awk '!x[$0]++' ; done)

	echo $videourl | sed 's/\ /\n/g' | awk '!x[$0]++' > /tmp/porn.org
	emacs --no-window-system /tmp/porn.org
	rm /tmp/porn.org
} # }}}
fap-ujizz() { # {{{
        keyword="$(echo "http://www.youjizz.com/search/$@" | sed 's/ /\-/g')"
	pagenum=5
	pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword-$num".html""; done )
	videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
	| awk '/\.com\/videos/ {print $2}' | awk '!x[$0]++' ; done)
	
	echo $videourl | sed 's/\ /\n/g' | awk '!x[$0]++' > /tmp/porn.org
	emacs --no-window-system /tmp/porn.org
	rm /tmp/porn.org 
}
# }}}
fap-pornotube() { # {{{
        keyword="$(echo "http://www.pornotube.com/search.php?q=$@" | sed 's/ /\+/g')"
	pagenum=3
	pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword&page=$num"; done )
	videourl=$(echo "$pagenum_to_url" | while read line; do	curl -s "$line" \
	| awk '/pornotube.com\/m/ && !/class/' | cut -d\" -f 2 | awk '!x[$0]++' ; done)

	echo $videourl | sed 's/\ /\n/g' | awk '!x[$0]++' > /tmp/porn.org
	emacs --no-window-system /tmp/porn.org
	rm /tmp/porn.org
}
# }}}
fap-xvideos() { # {{{
        keyword="$(echo "http://www.xvideos.com/?k=$@" | sed 's/ /\+/g')"
	pagenum=5
	pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword&p=$num"; done )
	videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
	| awk '/xvideos\.com\/video/ {print $2}' | awk '!x[$0]++' ; done)

	echo $videourl | sed 's/\ /\n/g' | awk '!x[$0]++' > /tmp/porn.org
	emacs --no-window-system /tmp/porn.org
#	rm /tmp/porn.org
}
# }}}
fap-jizzhut() { # {{{
        keyword="$(echo "http://www.jizzhut.com/search/$@" | sed 's/ /\-/g')"
	pagenum=3
	pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword-$num.html"; done )
	videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
	| awk '/jizzhut\.com\/videos/ {print $2}' | awk '!x[$0]++' ; done)

	echo $videourl | awk '!x[$0]++' > /tmp/porn.org
	emacs --no-window-system /tmp/porn.org
	rm /tmp/porn.org
}
# }}}
fap-redtube() { # {{{
        keyword="$(echo "http://www.redtube.com/?search=$@" | sed 's/ /\+/g')"
	pagenum=3
	pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword&page=$num"; done )
	videourl=$(echo "$pagenum_to_url" | while read line; do lynx -source "$line" \
	| awk -F\" '/class="s"/ {print $4, "http://redtube.com"$2}' | awk '!x[$0]++' ; done)

	echo $videourl | awk '!x[$0]++' > /tmp/porn.org
	emacs --no-window-system /tmp/porn.org
	rm /tmp/porn.org
}
# }}}
# quvi
fap-tnaflix() { # {{{
        keyword="$(echo "&what=$@&category=&sb=relevance&su=anytime&sd=all&dir=desc" | sed 's/ /\%20/g')"
	pagenum=3
	pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo \
		"http://www.tnaflix.com/search.php?page=$num$keyword"; done )
	videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
	| awk '/video[0-9]/ {print $2}' | awk '!x[$0]++' ; done)

	echo $videourl | sed 's/\ /\n/g' | > /tmp/porn.org
	emacs --no-window-system /tmp/porn.org
	rm /tmp/porn.org
} # }}}
fap-empflix() { # {{{
        keyword="$(echo "&what=$@&category=&sb=relevance&su=anytime&sd=all&dir=desc" | sed 's/ /\%20/g')"
	pagenum=3
	pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo \
		"http://www.empflix.com/search.php?page=$num$keyword"; done )
	videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
	| awk '/empflix\.com\/videos/ {print $2}' | awk '!x[$0]++' ; done)

	echo $videourl | sed 's/\ /\n/g' | > /tmp/porn.org
	emacs --no-window-system /tmp/porn.org
	rm /tmp/porn.org
}
# }}}
fap-spankwire() { # {{{
        keyword="$(echo "http://www.spankwire.com/search/straight/keyword/$@" | sed 's/ /\%20/g')"
	pagenum=5
	pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword?Sort=Relevance&Page=$num"; done )
	videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
	| awk '/www\.spankwire\.com/ && /video/ {print $2}' | awk '!x[$0]++' ; done)

	echo $videourl | sed 's/\ /\n/g' > /tmp/porn.org
	emacs --no-window-system /tmp/porn.org
	rm /tmp/porn.org
}
# }}}

pornhub-dl() { # {{{
	url=$(lynx --source "$1" | grep cdn1b \
	| cut -d\, -f4 | cut -d\: -f2 | cut -d\" -f1-2 | cut -d\" -f2 | head -1 \
	| sed 's/%3A/:/g' | sed 's:%2F:/:g' | sed 's:%3F:?:g' |sed 's:%3D:=:g' | sed 's:%26:\&:g')

	videotitle=$(lynx --source "$1" | grep "tumblr_video_caption =" | cut -d\" -f2)
	videoextension=$(echo $url | cut -d\? -f1 | rev | cut -d\. -f1 |rev)

	wget "$url" -O "$videotitle"."$videoextension"
}

# useage: xxx-dl http://www.youporn.com/watch/388214/incredible-blonde-gets-fucked-and-creamed
xxx-dl() {
    # checks if links is valid then dl from supported sites
    if [[ "$1" == *pornhub.com* ]]; then
	pornhub-dl "$1"
    else
	if [[ "$1" == *youporn.com* ]]; then
	    youporn-dl "$1"
	else
   	    echo "Link not valid"
	fi
    fi
} # }}}
# }}}


