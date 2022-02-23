# -*- shell-script -*-

[ `uname -s` != CYGWIN_NT-10.0 ] && return

[ -n "$ssh_agent_been_here" ] &&
    unset ssh_agent_been_here &&
    return ||
    export ssh_agent_been_here=1

envfile=$HOME/.ssh/agent
if [ -f "$envfile" ] ; then
    . $envfile
    [ -f /proc/$SSH_AGENT_PID/uid ] &&
	piduser=$( cat /proc/$SSH_AGENT_PID/uid )
    [ -S "$SSH_AUTH_SOCK" ] &&
	sockuser=$( stat -c %u $SSH_AUTH_SOCK )
    uid=$( id -u )
fi

if [ -d "/proc/$SSH_AGENT_PID" -a \
     -S "$SSH_AUTH_SOCK" -a	  \
     "$piduser"  == "$uid" -a	  \
     "$sockuser" == "$uid" ] ; then
    export SSH_AGENT_PID SSH_AUTH_SOCK
    ssh-add -l
    return
fi
unset SSH_AGENT_PID SSH_AUTH_SOCK

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval $( ssh-agent )
    echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK"  > $envfile
    echo "SSH_AGENT_PID=$SSH_AGENT_PID" >> $envfile
fi
