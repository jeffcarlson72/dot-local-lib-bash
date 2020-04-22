# -*- shell-script -*-

# Don't need to run unless this is an interactive session
case $( caller ) in
    *rc)
	return
	;;
esac

bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'
