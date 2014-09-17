#!/bin/bash
#####################################################################################
# Installation
# ------------
#
# 1) Copy script to your home folder
#  cd ~
#  wget https://raw.githubusercontent.com/serkanyersen/dotfiles/master/to.sh
#
# 2) Open file and change defaults for your needs
#
# 3) Give executable permissions
#  chmod +x to.sh
#
# 4) Link it to your bin folder (as `to` not `to.sh`)
#  -) For mac os x
#    ln -s ~/to.sh /usr/local/bin/to
#
#  -) For linux
#    ln -s ~/to.sh /usr/bin/to
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
DEBUG=0

# Display usage
usage() {
    echo -e "$GREEN Usage$NO_COLOR: Calling without arguments will connect using defaults
$GREEN Defaults$NO_COLOR: $CMD $USER@$HOST $TMUX
$GREEN Parameters$NO_COLOR:
    [-h <hostname>]$GRAY Change host name$NO_COLOR
    [-u <user>]$GRAY Change username$NO_COLOR
    [-n]$GRAY Don't attach tmux$NO_COLOR
    [-s]$GRAY Use SSH instead of MOSH$NO_COLOR
    [-d]$GRAY Debug the output$NO_COLOR
    [--h]$GRAY Display this message$NO_COLOR" 1>&2;
    exit 1;
}

# Get the passed options for this command
while getopts ":h:u:nsd" o; do
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
        d)
            DEBUG=1
            ;;
        *)
            usage
            ;;
    esac
done

# Change the title of the window
echo -e '\033k'$USER@$HOST'\033\\'

# Execute the command
if [ $DEBUG = 1 ]; then
    echo 'Command to execute:'
    echo -e $GREEN$CMD $USER@$HOST $TMUX $NO_COLOR
else
    # Print progress
    echo -e $GREEN'Connecting to' $HOST$NO_COLOR
    $CMD $USER@$HOST $TMUX
fi

# Exit with success
exit 0
