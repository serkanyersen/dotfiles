#!/bin/bash
#####################################################################################
# License
# -------
# Copyright (c) 2014 Serkan Yersen
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
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
USER=''

# Configs
VERSION=1.0.0
TMUX='-- tmux attach -d'
CMD='mosh'
DEBUG=0

# Display usage
usage() {
    echo -e "$GREEN Usage$NO_COLOR: Calling without arguments will connect using defaults
$GREEN Version:$NO_COLOR: $VERSION
$GREEN Defaults$NO_COLOR: $CMD $USER$HOST $TMUX
$GREEN Parameters$NO_COLOR:
    [-h <hostname>]$GRAY Change host name$NO_COLOR
    [-u <user>]$GRAY Change username$NO_COLOR
    [-n]$GRAY Don't attach tmux$NO_COLOR
    [-s]$GRAY Use SSH instead of MOSH$NO_COLOR
    [-d]$GRAY Debug the output$NO_COLOR
    [--v | --version]$GRAY Print version$NO_COLOR
    [--h | --help]$GRAY Display this message$NO_COLOR" 1>&2;
}

# Get the passed options for this command
while getopts ":h:u:-:nsd" o; do
    case "${o}" in
        # to support double dash options --help
        -)
            case "${OPTARG}" in
                h | help)
                    usage
                    exit 0
                    ;;
                v | version)
                    echo $VERSION
                    exit 0
                    ;;
                *)
                    if [ "$OPTERR" = 1 ] && [ "${optspec:0:1}" != ":" ]; then
                        echo -e "$CYAN --$OPTARG is an unknown option$NO_COLOR" >&2
                    fi
                    usage
                    exit 1
                    ;;
            esac;;
        h)
            HOST=${OPTARG}
            ;;
        u)
            USER=${OPTARG}@
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
        \?)
            echo -e "$CYAN -$OPTARG is an unknown option$NO_COLOR" >&2
            usage
            exit 1
            ;;
        :)
            echo  -e "$CYAN Option -$OPTARG requires an argument.$NO_COLOR" >&2
            usage
            exit 1
            ;;
    esac
done

# Change the title of the window
echo -e '\033k'$USER$HOST'\033\\'

# Execute the command
if [ $DEBUG = 1 ]; then
    echo 'Command to execute:'
    echo -e $GREEN$CMD $USER$HOST $TMUX $NO_COLOR
else
    # Print progress
    echo -e $GREEN'Connecting to' $HOST$NO_COLOR
    $CMD $USER$HOST $TMUX
fi

# Exit with success
exit 0
