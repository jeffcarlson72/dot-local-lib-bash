# -*- shell-script -*-

export DISPLAY=127.0.0.1:0.0
export PULSE_SERVER=tcp:127.0.0.1

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval $( ssh-agent )
fi
