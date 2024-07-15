# -*- shell-script -*-

type -p exa > /dev/null || return

alias exa='exa --icons=auto'

exag ()
{
    exa -ghl			  \
	--group-directories-first \
	--git			  \
	--git-ignore		  \
	--icons=always            \
	--color=always		  \
	$@ | less -FMR
}

exat ()
{
    exa -T			  \
	--group-directories-first \
	--icons=always            \
	--color=always		  \
	$@ | less -FMR
}
