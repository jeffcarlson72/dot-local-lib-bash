# -*- shell-script -*-

BGBLK1="$( tput setab 0 )"
BGRED1="$( tput setab 1 )"
BGGRN1="$( tput setab 2 )"
BGYLO1="$( tput setab 3 )"
BGBLU1="$( tput setab 4 )"
BGMAG1="$( tput setab 5 )"
BGCYA1="$( tput setab 6 )"
BGWHT1="$( tput setab 7 )"
BGBLK2="$( tput setab 8 )"
BGRED2="$( tput setab 9 )"
BGGRN2="$( tput setab 10 )"
BGYLO2="$( tput setab 11 )"
BGBLU2="$( tput setab 12 )"
BGMAG2="$( tput setab 13 )"
BGCYN2="$( tput setab 14 )"
BGWHT2="$( tput setab 15 )"

FGBLK1="$( tput setaf 0 )"
FGRED1="$( tput setaf 1 )"
FGGRN1="$( tput setaf 2 )"
FGYLO1="$( tput setaf 3 )"
FGBLU1="$( tput setaf 4 )"
FGMAG1="$( tput setaf 5 )"
FGCYA1="$( tput setaf 6 )"
FGWHT1="$( tput setaf 7 )"
FGBLK2="$( tput setaf 8 )"
FGRED2="$( tput setaf 9 )"
FGGRN2="$( tput setaf 10 )"
FGYLO2="$( tput setaf 11 )"
FGBLU2="$( tput setaf 12 )"
FGMAG2="$( tput setaf 13 )"
FGCYA2="$( tput setaf 14 )"
FGWHT2="$( tput setaf 15 )"

BOLD="$( tput bold )"
RESET="$( tput sgr0 )"

__ps1flash()
{
    if [ "$1" -ne 0 ] ; then
	echo "$FGRED2"
    fi
}

if [ $( uname -s ) == 'CYGWIN_NT-10.0' ] ; then
    g="/cygdrive/c/Program Files/Git"
    PS1='[\[$FGCYA1\]${USER#*+}\[$RESET\]'
    PS1+='@'
    PS1+='\[$FGMAG1\]${HOSTNAME,,*}\[$RESET\]'
    PS1+=' '
    PS1+='\[$FGBLU2\]\W\[$RESET\]]'
    if [ -f "$g/mingw64/share/git/completion/git-prompt.sh" ] ; then
	. "$g/mingw64/share/git/completion/git-prompt.sh"
	PS1+='$( __git_ps1 "(%s)" )'
    fi
    PS1+='\[$( __ps1flash $? )\]\$\[$RESET\] '
    unset g
elif [ $( uname -s ) == 'AIX' ] ; then
    if [ ${TERM#*-} == 256color ] ; then
	TERM=${TERM%-*}-16color
    fi
    # AIX colors seem to be based on BGR rather than RGB.  Endian difference?
    PS1='\[$( tput setf 3 )\]\u\[$RESET\]'
    PS1+='@'
    PS1+='\[$( tput setf 11 ; tput setb 1 )\]\h\[$RESET\]'
    PS1+=':'
    PS1+='\[$( tput setf 9 )\]\W\[$RESET\]'
    PS1+='\$> '
elif [ $( uname -s ) == 'Linux' ] ; then
    if type -t git > /dev/null ; then
	    gitversion=$( git --version | awk '{print $NF}' )
	    gitdocs=/usr/share/doc/git-$gitversion/
    fi
    if [ -f /etc/centos-release -o -f /etc/fedora-release ] ; then
	br0='['
	br1=']'
	host='\[${FGWHT1}${BGBLU1}\]\h\[$RESET\]'
	sep=' '
    elif [ -f /etc/redhat-release ] ; then
	br0='['
	br1=']'
	host='\[$FGRED1\]\h\[$RESET\]'
	sep=' '
    elif [ -f /etc/fedora-release ] ; then
	br0='['
	br1=']'
	host='\[${BOLD}${FGBLU1}\]\h\[$RESET\]'
	sep=' '
    elif [ -f /etc/SuSE-release ] ; then
	br0='<'
	br1='>'
	host='\[$FGGRN1\]\h\[$RESET\]'
	sep=' '
    elif [ -f /etc/debian_version ] ; then
	br0=''
	br1=''
	host='\[${BOLD}${FGGRN2}\]\h\[$RESET\]'
	sep=':'
    fi
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
    fi
    PS1='${debian_chroot:+($debian_chroot)}'
    PS1+="$br0"
    PS1+='\[$FGCYA1\]\u\[$RESET\]'
    PS1+='@'
    PS1+="$host"
    PS1+="$sep"
    PS1+='\[$FGBLU2\]\W\[$RESET\]'
    PS1+="$br1"
    if [ -f "$gitdocs/contrib/completion/git-prompt.sh" ] ; then
	. "$gitdocs/contrib/completion/git-prompt.sh"
	PS1+='$( rc=$? ; __git_ps1 "(%s)" ; exit $rc )'
    fi
    PS1+='\[$( __ps1flash $? )\]\$\[$RESET\] '
    unset br0 br1 gitdocs gitversion host
fi

PS2='\!> '

export PS1 PS2
