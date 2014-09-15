#!/bin/bash

usage() { echo -e "Usage: $0\n\t[-h <hostname>] Host Name\n\t[-u <user>] Username\n\t[-n] Don't use tmux\n\t[-s] Use SSH instead of MOSH" 1>&2; exit 0; }

HOST='addv4'
USER='serkan'
TMUX='-- tmux attach -d'
CMD='mosh'

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
