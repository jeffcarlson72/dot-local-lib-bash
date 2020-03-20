# -*- shell-script -*-

sockfile=$HOME/.ssh/agent
if [ -f "$sockfile" ] ; then
    . $sockfile
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
    echo "Agent pid $SSH_AGENT_PID (*)"
    return
fi
unset SSH_AGENT_PID SSH_AUTH_SOCK

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval $( ssh-agent )
    echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK"  > $sockfile
    echo "SSH_AGENT_PID=$SSH_AGENT_PID" >> $sockfile
fi
