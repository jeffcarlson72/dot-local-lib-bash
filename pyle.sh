# -*- shell-script -*-

type -p pygmentize >/dev/null || return

pyle()
{
    if [ $# -eq 1 ] ; then
	opt=-g
    fi
    pygmentize $opt $@ | less -MR
}
