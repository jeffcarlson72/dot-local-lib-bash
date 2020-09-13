# -*- shell-script -*-

type -p exa > /dev/null || return

exag ()
{
    exa -ghl			  \
	--group-directories-first \
	--git			  \
	--git-ignore		  \
	--color=always		  \
	$@ | less -FMR
}

exat ()
{
    exa -T			  \
	--group-directories-first \
	--color=always		  \
	$@ | less -FMR
}
