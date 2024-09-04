# -*- shell-script -*-

# Only call this in .bashrc
case $( caller ) in
    *profile)
	return
	;;
esac
[[ "$-" == *i* ]] || return

__ps1flash()
{
    if [ "$1" -ne 0 ] ; then
	if [ $( uname -s ) == AIX ] ; then
	    tput setf 12
	else
	    tput setaf 9
	fi
    fi
}

reset="$( tput sgr0 )"

if [ $( id -u ) -eq 0 ] ; then
    user="$( tput setaf 9 )"
else
    user="$( tput setaf 6 )"
fi

wdir="$( tput setaf 4 ; tput bold )"
br0='['
br1=']'
sep=' '
end=''

case $( uname -s ) in
    AIX)
	if [ ${TERM#*-} == 256color ] ; then
	    TERM=${TERM%-*}-16color
	fi
	if [ $( id -u ) -eq 0 ]	; then
	    user="$( tput setf 4 )"
	else
	    user="$( tput setf 3 )"
	fi
	host="$( tput setf 11 ; tput setb 1 )"
	wdir="$( tput setf 9 )"
	br0=''
	br1=''
	sep=':'
	end='>'
	;;
    CYGWIN_NT-10.0)
	gitdocs="/cygdrive/c/Program Files/Git/mingw64/share/git"
	host="$( tput setaf 5 )"
	;;
    Darwin)
	gitdocs=/library/Developer/CommandLineTools/usr/share/git-core/
	wdir="$( tput setaf 32 )"
	host="$( tput setab 250 ; tput setaf 238 )"
	br0='['
	br1=''
	sep=']'
	end=''
	;;
    FreeBSD)
	host="$( tput setaf 80 ; tput setab 220 )"
	;;
    Linux)
	if type -t git > /dev/null ; then
	    if [ -d "/usr/share/doc/git/contrib/" ] ; then
		gitdocs="/usr/share/doc/git/contrib/"
	    else
		gitversion=$( git --version | awk '{print $NF}' )
		gitdocs="/usr/share/doc/git-$gitversion/contrib/"
	    fi
	fi

	[ -f /etc/centos-release ] && ID=centos
	[ -f /etc/redhat-release ] && ID=redhat
	[ -f /etc/os-release ] && . /etc/os-release
	case $ID in
	    centos|fedora|redhat|rhel|almalinux|rockylinux)
		host="$( tput setaf 4 )"
		;;
	    debian|ubuntu)
		host="$( tput setaf 1 )"
		br0=''
		br1=''
		sep=':'
		;;
	    opensuse*|sled|sles|suse)
		host="$( tput setaf 2 )"
		br0='<'
		br1='>'
		;;
	esac

	unset ANSI_COLOR BUG_REPORT_URL CPE_NAME HOME_URL ID ID_LIKE	\
	      NAME PRETTY_NAME REDHAT_BUGZILLA_PRODUCT			\
	      REDHAT_BUGZILLA_PRODUCT_VERSION REDHAT_SUPPORT_PRODUCT	\
	      REDHAT_SUPPORT_PRODUCT_VERSION VARIANT VARIANT_ID VERSION \
	      VERSION_ID
	;;
    NetBSD)
	host="$( tput setaf 202 ; tput setab 238 )"
	;;
    OpenBSD)
	host="$( tput setaf 21 ; tput setab 81 )"
	;;
    SunOS)
	host="$( tput setaf 5 ; tput setab 3 )"
	;;
esac

if [ -z "${debian_chroot:-}" -a -r "/etc/debian_chroot" ]; then
    debian_chroot=$( cat /etc/debian_chroot )
fi

PS1='${debian_chroot:+(debian_chroot)}'
PS1+="$br0"
PS1+="\[$user\]\u\[$reset\]"
PS1+='@'
PS1+="\[$host\]\h\[$reset\]"
PS1+="$sep"
PS1+="\[$wdir\]\W\[$reset\]"
PS1+="$br1"
if [ -f "$gitdocs/completion/git-prompt.sh" ] ; then
    . "$gitdocs/completion/git-prompt.sh"
    PS1+='$( rc=$? ; __git_ps1 "(%s)" ; exit $rc )'
fi
PS1+='\[$( __ps1flash $? )\]\$\[$reset\]'
PS1+="$end "

PS2='\!> '

export PS1 PS2
unset br0 br1 end gitdocs gitversion host sep user wdir
