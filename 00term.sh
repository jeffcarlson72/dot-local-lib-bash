# -*- shell-script -*-

if  [ -f /usr/share/terminfo/*/${TERM}-256color ] ; then
    TERM=${TERM}-256color
    export TERM
fi
