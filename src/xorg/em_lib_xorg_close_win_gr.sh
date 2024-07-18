#!/bin/echo It's a subscript

##.###########################################################################.
##! Copyright (C) Марков Евгений 2024
##!
##! \file   em_lib_xorg_close_win_gr.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2024-01-28 16:15 UTC+00:00
##!
##! \brief  X-org. Close the window gracefully.
##|
##'###########################################################################'


em_source "./em_lib_xorg_win_exist_p.sh"


# :BEGIN:
##.***************************************************************************.
##| Lib: xorg/em_lib_xorg_close_win_gr.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} wmctrl"

##.================================================================.
##! \brief X-org. Close the window gracefully.
##!
##! \param $1 - window title (regexp для grep).
##! \param $2 - yes: exact title string.
##!
##! \return  - return code :
##!                 1 - не такого окна.
##|
##'================================================================'
em_lib_xorg_close_win_gr () {

    local wid rv

    wid="$(em_lib_xorg_win_exist_p "${1}" ${2})"; rv=${?}
    [ ${rv} != 0 ] && return ${rv}
    for w in ${wid};do
        wmctrl -i -c "${w}"
    done
    return 0
}
#export -f em_lib_xorg_close_win_gr



# :END:
