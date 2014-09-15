#!/bin/bash
#####################################################################################
# Installation
# ------------
#
# 1) Copy script to your home folder
# -$ cd ~
# -$ wget https://raw.githubusercontent.com/serkanyersen/dotfiles/master/to.sh
#
# 2) Open file and change defaults for your needs
#
# 3) Give executable permissions
# -$ chmod +x to.sh
#
# 4) Link it to your bin folder (as `to` not `to.sh`)
#  -) For mac os x
#     -$ ln -s ~/to.sh /usr/local/bin/to
#  -) For linux
#     -$ ln -s ~/to.sh /usr/bin/to
#
# That's it, Enjoy :)
#####################################################################################

# Colors
GRAY="\033[1;30m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
LIGHT_CYAN="\033[1;36m"
NO_COLOR="\033[0m"

# Defaults
HOST='addv4'
USER='serkan'

# Configs
TMUX='-- tmux attach -d'
CMD='mosh'

# Display usage
usage() {
    echo -e "$GREEN Usage$NO_COLOR: Calling without arguments will connect using defaults
$GREEN Defaults$NO_COLOR: $CMD $USER@$HOST $TMUX
$GREEN Parameters$NO_COLOR:
    [-h <hostname>]$GRAY Change host name$NO_COLOR
    [-u <user>]$GRAY Change username$NO_COLOR
    [-n]$GRAY Don't attach tmux$NO_COLOR
    [-s]$GRAY Use SSH instead of MOSH$NO_COLOR
    [--h]$GRAY Display this message$NO_COLOR" 1>&2;
    exit 0;
}

while getopts ":h:u:ns" o; do
    case "${o}" in
        h)
            HOST=${OPTARG}
            ;;
        u)
            USER=${OPTARG}
            ;;
        n)
            TMUX=''
            ;;
        s)
            CMD='ssh'
            if [ -n "$TMUX" ]
            then
                TMUX="-t tmux attach -d"
            fi
            ;;
        *)
            usage
            ;;
    esac
done

echo Connecting to $HOST
$CMD $USER@$HOST $TMUX

exit 1
