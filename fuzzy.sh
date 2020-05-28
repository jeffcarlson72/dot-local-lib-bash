# -*- shell-script -*-

type -p fzf > /dev/null || return

dox()
{
    doc=$( find /usr/share/doc -type f | sort | fzf )
    case $( basename "$doc" ) in
        *.gif|*.ico|*.jpg|*.jpeg|*.png)
            display "$doc" &
            ;;
        *.htm|*.html)
            lynx "$doc"
            ;;
        *.pdf)
            atril "$doc" &
            ;;
        *)
            less "$doc"
            ;;
    esac
    unset doc
}

h()
{
    $( history | awk '{$1 = ""; print}' | fzf )
}

type -p colorize > /dev/null || type -p ccze > /dev/null || return

logs()
{
    clrz=$( type -p colorize || type -p ccze )

    sudo find /var/log/ -type f ! -name wtmp ! -name btmp |
        fzf |
        xargs -i sudo cat {} |
        $clrz |
        less -MR
}
