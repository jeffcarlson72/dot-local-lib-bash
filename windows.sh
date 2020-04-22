# -*- shell-script -*-

[ $( uname -s ) != "CYGWIN_NT-10.0" -o \
  $( uname -s ) != "MINGW64_NT-10.0-18363" ] && return

alias ~~='cd $USERPROFILE'
