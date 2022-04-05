# -*- shell-script -*-

# uutils is an implementation of most of the GNU coreutils in Rust.

if [ ! -x /usr/local/bin/uls -o \
     ! -x /usr/bin/uls -o \
     ! -x /bin/uls ] ; then
    return
fi

alias uls='uls --color=auto'
alias ull='uls --color=auto -l'
alias ul.='uls --color=auto -d .*'
