# -*- shell-script -*-

if [[ $TERM =~ color ]] ; then
    case $( uname -s ) in
	SunOS)
	    [ -x /usr/gnu/bin/ls ] && alias ls='/usr/gnu/bin/ls --color=auto'
	    ;;
	Linux)
	    alias ls='ls --color=auto'
	    ;;
    esac
fi

alias ll='ls -l'
alias l.='ls -d .*'
