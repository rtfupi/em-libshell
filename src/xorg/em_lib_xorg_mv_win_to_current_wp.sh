#!/bin/echo It's a subscript

##.###########################################################################.
##! Copyright (C) Марков Евгений 2022
##!
##! \file   em_lib_xorg_current_wp.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2022-02-14 Пн 21:52
##!
##! \brief  X-org. Переместить окно в текущий workspace.
##|
##'###########################################################################'


em_source "./em_lib_xorg_win_exist_p.sh"
em_source "./em_lib_xorg_current_wp.sh"


# :BEGIN:
##.***************************************************************************.
##| Lib: xorg/em_lib_xorg_mv_win_to_current_wp.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} wmctrl"

##.================================================================.
##! \brief Переместить окно в текущий workspace.
##!
##! \param $1 - window title (regexp для grep).
##! \param $2 - yes: exact title string.
##!
##! \return  - stdout :
##!                 номер workspace-а (0, 1 ...).
##!          - return code :
##!                 1 - не найдена команда wmctrl;
##!                 2 - не такого окна.
##|
##'================================================================'
em_lib_xorg_mv_win_to_current_wp () {

    local wid rv
    local wp=$(em_lib_xorg_current_wp)

    wid="$(em_lib_xorg_win_exist_p "${1}" ${2})"; rv=${?}
    [ ${rv} != 0 ] && return ${rv}
    for w in ${wid};do
        wmctrl -i -t "${wp}" -R "${w}"
    done
    return 0
}
#export -f em_lib_xorg_mv_win_to_current_wp



# :END:
