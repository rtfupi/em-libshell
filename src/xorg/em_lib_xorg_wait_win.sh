#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2022
##!
##! \file   em_lib_xorg_wait_win.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2022-02-14 Пн 21:52
##!
##! \brief  X-org. Ожидать создания окна.
##|
##'###########################################################################'


em_source "./em_lib_xorg_win_exist_p.sh"

# :BEGIN:
##.***************************************************************************.
##| Lib: xorg/em_lib_xorg_wait_win.sh
##|
##'***************************************************************************'

##.================================================================.
##! \brief  Ожидать создания окна.
##!
##! \param $1 - window title (regexp для grep);
##! \param $2 - время ожидания (кратно 0.1 мс, default 10).
##!
##! \return  - stdout :
##!                 window title.
##!          - return code :
##!                 1 - не найдена команда wmctrl;
##!                 2 - не такого окна.
##|
##'================================================================'
em_lib_xorg_wait_win () {

    local s
    local delay=${2}

    [ -n "${delay}" ] && delay=10

    for i in $(seq 1 ${delay}); do
        s=$(em_lib_xorg_win_exist_p "${1}")
        r=$?
        LANG=C sleep 0.1; # учтем время реакции оконной системы.
        case $? in
            0)
                echo "${s}"; return 0;;
            1)
                return 1;;
        esac
    done
    return 2
}
#export -f em_lib_xorg_wait_win



# :END:
