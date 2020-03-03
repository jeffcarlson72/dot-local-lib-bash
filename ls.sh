# -*- shell-script -*-

if [[ $TERM =~ color ]] ; then
    alias ls='ls --color=auto'
    alias ll='ls --color=auto -l'
    alias l.='ls --color=auto -d .*'
fi
