# -*- shell-script -*-

# uutils is an implementation of most of the GNU coreutils in Rust.

if [ ! -x /usr/local/bin/uls -a \
     ! -x /usr/bin/uls       -a \
     ! -x /bin/uls ] ; then
    return
fi

alias uls='uls --color=auto'
alias ull='uls -l'
alias ul.='uls -d .*'
