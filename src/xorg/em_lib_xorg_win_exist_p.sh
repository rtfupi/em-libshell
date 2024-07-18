#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2022
##!
##! \file   em_lib_xorg_win_exist_p.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2022-02-14 Пн 21:52
##!
##! \brief  X-org. Предикат существования окна.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: xorg/em_lib_xorg_win_exist_p.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} wmctrl"

##.================================================================.
##! \brief Предикат существования окна.
##!
##! \param $1 - window title (regexp для sed, символы начала и конца строки
##!             устанавливаются автоматически);
##! \param $2 - yes: exact title string;
##! \param $3 - формат представления WID (команда printf).
##!
##! \return  - stdout :
##!                 list of window ID.
##!          - return code :
##!                 0 - Ok;
##!                 1 - не такого окна.
##|
##'================================================================'
em_lib_xorg_win_exist_p () {

    local fmt="%d"
    local ti="${1}"
    local wid

    if [ y${2} = yyes ];then
        ti="$(echo "$ti"|sed 's,[]/\\$*^.[],\\&,g')"
    fi

    wid="$(wmctrl -l|sed -n "s/^\([0-9xabcdef]\+\)[ \t]\+`
                             `[^ \t]\+[ \t]\+`
                             `[^ \t]\+[ \t]\{1\}`
                             `\(${ti}\)\$/\1/gp")"

    [ -z "${wid}" ] && return 1
    for w in ${wid};do
        printf "${fmt}\n" "${w}"
    done
    return 0
}
#export -f em_lib_xorg_win_exist_p



# :END:
