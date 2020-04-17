# -*- shell-script -*-

[ `uname -s` != CYGWIN_NT-10.0 ] && return

PYPATH="/cygdrive/c/tools/Anaconda3"
PYPATH+=":/cygdrive/c/tools/Anaconda3/Library/mingw-w64/bin"
PYPATH+=":/cygdrive/c/tools/Anaconda3/Library/usr/bin"
PYPATH+=":/cygdrive/c/tools/Anaconda3/Library/bin"
PYPATH+=":/cygdrive/c/tools/Anaconda3/Scripts"
PYPATH+=":/cygdrive/c/tools/Anaconda3/bin"
PYPATH+=":/cygdrive/c/tools/Anaconda3/condabin"

PATH="$PYPATH:$PATH"

PATH+=":/cygdrive/c/Program Files (x86)/Nmap"
