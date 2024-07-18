#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023.
##!
##! \file   em_lib_xorg_win_down.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-03-30 17:14
##!
##! \brief  Если фокус на целевом term, то убрать с переднего плана.
##|
##'###########################################################################'


em_source "../xorg/em_lib_xorg_current_wp.sh"
em_source "../xorg/em_lib_xorg_get_win_focus.sh"
em_source "../xorg/em_lib_xorg_win_exist_p.sh"


# :BEGIN:
##.***************************************************************************.
##| Lib: xorg/em_lib_xorg_win_down.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} xdotool"

##.================================================================.
##! \brief Если фокус на целевом term, то убрать с переднего плана.
##!
##! \param $1 - window title (regexp для sed, символы начала и конца строки
##!             устанавливаются автоматически);
##! \param $2 - yes: exact title string;
##!
##! \return  - stdout :
##!                 window title.
##!          - return code :
##!                 0 - Ok;
##!                 1 - окно в фокусе не совпало с целевым окном;
##!                 2 - нет окна с таким title.
##|
##'================================================================'
em_lib_xorg_win_down () {
    local wp="$(em_lib_xorg_current_wp)"
    local wid1="$(em_lib_xorg_get_win_focus)"
    local wid2="$(em_lib_xorg_win_exist_p "${1}" ${2})"

    if [ -n "${wid2}" ]; then
        if [ "${wid1}" -eq "${wid2}" ];then
            xdotool windowminimize "${wid1}" > /dev/null 2>&1
            return 0
        fi
        return 1
    fi
    return 2
}
#export -f em_lib_xorg_win_down



# :END:
