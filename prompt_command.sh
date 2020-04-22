# -*- shell-script -*-

[ -f /etc/redhat-release ] && return

# Only call this in .bashrc
case $( caller ) in
    *profile)
	return
	;;
esac

case $TERM in
    screen*)
	PROMPT_COMMAND='printf "\033k%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
	;;
    *)
	PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
	;;
esac

export PROMPT_COMMAND
