# -*- shell-script -*-

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval $( ssh-agent )
fi